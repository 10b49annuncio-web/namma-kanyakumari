import 'package:cloud_firestore/cloud_firestore.dart';

enum ComplaintStatus {
  pending,
  verified,
  assigned,
  inProgress,
  resolved,
  rejected,
  closed,
}

enum ComplaintPriority {
  low,
  medium,
  high,
  emergency,
}

class TimelineStep {
  final ComplaintStatus status;
  final String title;
  final String description;
  final DateTime timestamp;
  final String? updatedBy;

  TimelineStep({
    required this.status,
    required this.title,
    required this.description,
    required this.timestamp,
    this.updatedBy,
  });

  factory TimelineStep.fromMap(Map<String, dynamic> data) {
    return TimelineStep(
      status: ComplaintStatus.values.firstWhere(
        (e) => e.name == data['status'],
        orElse: () => ComplaintStatus.pending,
      ),
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedBy: data['updatedBy'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status.name,
      'title': title,
      'description': description,
      'timestamp': Timestamp.fromDate(timestamp),
      'updatedBy': updatedBy,
    };
  }
}

class ComplaintModel {
  final String complaintId;
  final String citizenId;
  final String citizenName;
  final String citizenPhone;
  final String title;
  final String description;
  final String category; // 'Roads', 'Street Light', 'Water Supply', 'Sanitation', etc.
  final String departmentId;
  final ComplaintPriority priority;
  final ComplaintStatus status;
  final List<String> imageUrls;
  final double? latitude;
  final double? longitude;
  final String address;
  final String taluk;
  final String village;
  final DateTime createdAt;
  final DateTime? resolvedAt;
  final List<TimelineStep> timeline;

  ComplaintModel({
    required this.complaintId,
    required this.citizenId,
    required this.citizenName,
    required this.citizenPhone,
    required this.title,
    required this.description,
    required this.category,
    required this.departmentId,
    this.priority = ComplaintPriority.medium,
    this.status = ComplaintStatus.pending,
    this.imageUrls = const [],
    this.latitude,
    this.longitude,
    required this.address,
    required this.taluk,
    required this.village,
    required this.createdAt,
    this.resolvedAt,
    this.timeline = const [],
  });

  factory ComplaintModel.fromMap(Map<String, dynamic> data, String id) {
    return ComplaintModel(
      complaintId: id,
      citizenId: data['citizenId'] ?? '',
      citizenName: data['citizenName'] ?? 'Citizen',
      citizenPhone: data['citizenPhone'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? 'General',
      departmentId: data['departmentId'] ?? 'general',
      priority: ComplaintPriority.values.firstWhere(
        (e) => e.name == data['priority'],
        orElse: () => ComplaintPriority.medium,
      ),
      status: ComplaintStatus.values.firstWhere(
        (e) => e.name == data['status'],
        orElse: () => ComplaintStatus.pending,
      ),
      imageUrls: List<String>.from(data['imageUrls'] ?? []),
      latitude: (data['latitude'] as num?)?.toDouble(),
      longitude: (data['longitude'] as num?)?.toDouble(),
      address: data['address'] ?? '',
      taluk: data['taluk'] ?? 'Agastheeswaram',
      village: data['village'] ?? 'Nagercoil',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      resolvedAt: (data['resolvedAt'] as Timestamp?)?.toDate(),
      timeline: (data['timeline'] as List<dynamic>?)
              ?.map((item) => TimelineStep.fromMap(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'complaintId': complaintId,
      'citizenId': citizenId,
      'citizenName': citizenName,
      'citizenPhone': citizenPhone,
      'title': title,
      'description': description,
      'category': category,
      'departmentId': departmentId,
      'priority': priority.name,
      'status': status.name,
      'imageUrls': imageUrls,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'taluk': taluk,
      'village': village,
      'createdAt': Timestamp.fromDate(createdAt),
      'resolvedAt': resolvedAt != null ? Timestamp.fromDate(resolvedAt!) : null,
      'timeline': timeline.map((e) => e.toMap()).toList(),
    };
  }
}
