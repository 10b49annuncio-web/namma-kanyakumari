import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/user_model.dart';
import '../models/complaint_model.dart';
import '../models/app_models.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Collection References
  CollectionReference get _usersRef => _firestore.collection('users');
  CollectionReference get _complaintsRef => _firestore.collection('complaints');
  CollectionReference get _departmentsRef => _firestore.collection('departments');
  CollectionReference get _emergencyRef => _firestore.collection('emergency_contacts');
  CollectionReference get _notificationsRef => _firestore.collection('notifications');

  // Stream single user profile
  Stream<UserModel?> streamUserProfile(String uid) {
    return _usersRef.doc(uid).snapshots().map((doc) {
      if (!doc.exists || doc.data() == null) return null;
      return UserModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    });
  }

  // Update user profile
  Future<void> updateUserProfile(UserModel user) async {
    await _usersRef.doc(user.uid).update(user.toMap());
  }

  // Create a new civic complaint
  Future<String> submitComplaint({
    required String citizenId,
    required String citizenName,
    required String citizenPhone,
    required String title,
    required String description,
    required String category,
    required String departmentId,
    required ComplaintPriority priority,
    required String address,
    required String taluk,
    required String village,
    double? latitude,
    double? longitude,
    List<File> imageFiles = const [],
  }) async {
    final DocumentReference docRef = _complaintsRef.doc();
    final String complaintId = 'NK-${DateTime.now().year}-${docRef.id.substring(0, 5).toUpperCase()}';

    // Upload images if provided
    List<String> uploadedUrls = [];
    for (int i = 0; i < imageFiles.length; i++) {
      final ref = _storage.ref().child('complaints/$complaintId/evidence_$i.jpg');
      final uploadTask = await ref.putFile(imageFiles[i]);
      final url = await uploadTask.ref.getDownloadURL();
      uploadedUrls.add(url);
    }

    final initialTimeline = [
      TimelineStep(
        status: ComplaintStatus.pending,
        title: 'Grievance Submitted',
        description: 'Report successfully logged into Kanyakumari citizen portal.',
        timestamp: DateTime.now(),
        updatedBy: citizenName,
      )
    ];

    final ComplaintModel complaint = ComplaintModel(
      complaintId: complaintId,
      citizenId: citizenId,
      citizenName: citizenName,
      citizenPhone: citizenPhone,
      title: title,
      description: description,
      category: category,
      departmentId: departmentId,
      priority: priority,
      status: ComplaintStatus.pending,
      imageUrls: uploadedUrls,
      latitude: latitude,
      longitude: longitude,
      address: address,
      taluk: taluk,
      village: village,
      createdAt: DateTime.now(),
      timeline: initialTimeline,
    );

    await docRef.set(complaint.toMap());
    return complaintId;
  }

  // Stream grievances submitted by citizen
  Stream<List<ComplaintModel>> streamCitizenComplaints(String citizenId) {
    return _complaintsRef
        .where('citizenId', isEqualTo: citizenId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ComplaintModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  // Stream all complaints for district oversight
  Stream<List<ComplaintModel>> streamAllComplaints() {
    return _complaintsRef
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ComplaintModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  // Update complaint status & append milestone to audit timeline
  Future<void> updateComplaintStatus({
    required String complaintDocId,
    required ComplaintStatus newStatus,
    required String statusTitle,
    required String remarks,
    required String officerName,
  }) async {
    final step = TimelineStep(
      status: newStatus,
      title: statusTitle,
      description: remarks,
      timestamp: DateTime.now(),
      updatedBy: officerName,
    );

    final updates = {
      'status': newStatus.name,
      'timeline': FieldValue.arrayUnion([step.toMap()]),
    };

    if (newStatus == ComplaintStatus.resolved) {
      updates['resolvedAt'] = Timestamp.now();
    }

    await _complaintsRef.doc(complaintDocId).update(updates);
  }

  // Stream Departments Directory
  Stream<List<DepartmentModel>> streamDepartments() {
    return _departmentsRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return DepartmentModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  // Stream Emergency Contacts
  Stream<List<EmergencyContactModel>> streamEmergencyContacts() {
    return _emergencyRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return EmergencyContactModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  // Stream Notifications for citizen
  Stream<List<NotificationModel>> streamNotifications(String citizenId) {
    return _notificationsRef
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return NotificationModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}
