import 'package:cloud_firestore/cloud_firestore.dart';

enum ComplaintStatus {
  submitted,
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

class ComplaintModel {
  final String complaintId;

  final String userId;
  final String userName;
  final String phoneNumber;

  final String category;
  final String description;

  final List<String> imageUrls;

  final double latitude;
  final double longitude;

  final String address;

  final ComplaintStatus status;
  final ComplaintPriority priority;

  final String? departmentId;
  final String? departmentName;

  final String? assignedOfficerId;
  final String? assignedOfficerName;

  final bool aiDetected;
  final String? aiPrediction;
  final double? aiConfidence;

  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? resolvedAt;

  final bool isPublic;

  const ComplaintModel({
    required this.complaintId,
    required this.userId,
    required this.userName,
    required this.phoneNumber,
    required this.category,
    required this.description,
    required this.imageUrls,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.status,
    required this.priority,
    required this.createdAt,
    this.departmentId,
    this.departmentName,
    this.assignedOfficerId,
    this.assignedOfficerName,
    this.aiDetected = false,
    this.aiPrediction,
    this.aiConfidence,
    this.updatedAt,
    this.resolvedAt,
    this.isPublic = true,
  });

  //----------------------------------------
  // Empty
  //----------------------------------------

  factory ComplaintModel.empty() {
    return ComplaintModel(
      complaintId: "",
      userId: "",
      userName: "",
      phoneNumber: "",
      category: "",
      description: "",
      imageUrls: [],
      latitude: 0,
      longitude: 0,
      address: "",
      status: ComplaintStatus.submitted,
      priority: ComplaintPriority.medium,
      createdAt: DateTime.now(),
    );
  }

  //----------------------------------------
  // CopyWith
  //----------------------------------------

  ComplaintModel copyWith({
    String? complaintId,
    String? userId,
    String? userName,
    String? phoneNumber,
    String? category,
    String? description,
    List<String>? imageUrls,
    double? latitude,
    double? longitude,
    String? address,
    ComplaintStatus? status,
    ComplaintPriority? priority,
    String? departmentId,
    String? departmentName,
    String? assignedOfficerId,
    String? assignedOfficerName,
    bool? aiDetected,
    String? aiPrediction,
    double? aiConfidence,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? resolvedAt,
    bool? isPublic,
  }) {
    return ComplaintModel(
      complaintId: complaintId ?? this.complaintId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      category: category ?? this.category,
      description: description ?? this.description,
      imageUrls: imageUrls ?? this.imageUrls,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      departmentId: departmentId ?? this.departmentId,
      departmentName: departmentName ?? this.departmentName,
      assignedOfficerId:
          assignedOfficerId ?? this.assignedOfficerId,
      assignedOfficerName:
          assignedOfficerName ?? this.assignedOfficerName,
      aiDetected: aiDetected ?? this.aiDetected,
      aiPrediction: aiPrediction ?? this.aiPrediction,
      aiConfidence: aiConfidence ?? this.aiConfidence,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      isPublic: isPublic ?? this.isPublic,
    );
  }

  //----------------------------------------
  // To Map
  //----------------------------------------

  Map<String, dynamic> toMap() {
    return {
      "complaintId": complaintId,
      "userId": userId,
      "userName": userName,
      "phoneNumber": phoneNumber,
      "category": category,
      "description": description,
      "imageUrls": imageUrls,
      "latitude": latitude,
      "longitude": longitude,
      "address": address,
      "status": status.name,
      "priority": priority.name,
      "departmentId": departmentId,
      "departmentName": departmentName,
      "assignedOfficerId": assignedOfficerId,
      "assignedOfficerName": assignedOfficerName,
      "aiDetected": aiDetected,
      "aiPrediction": aiPrediction,
      "aiConfidence": aiConfidence,
      "createdAt": Timestamp.fromDate(createdAt),
      "updatedAt": updatedAt == null
          ? null
          : Timestamp.fromDate(updatedAt!),
      "resolvedAt": resolvedAt == null
          ? null
          : Timestamp.fromDate(resolvedAt!),
      "isPublic": isPublic,
    };
  }

  //----------------------------------------
  // From Map
  //----------------------------------------

  factory ComplaintModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return ComplaintModel(
      complaintId: map["complaintId"] ?? "",
      userId: map["userId"] ?? "",
      userName: map["userName"] ?? "",
      phoneNumber: map["phoneNumber"] ?? "",
      category: map["category"] ?? "",
      description: map["description"] ?? "",
      imageUrls:
          List<String>.from(map["imageUrls"] ?? []),
      latitude:
          (map["latitude"] ?? 0).toDouble(),
      longitude:
          (map["longitude"] ?? 0).toDouble(),
      address: map["address"] ?? "",
      status: ComplaintStatus.values.firstWhere(
        (e) => e.name == map["status"],
        orElse: () =>
            ComplaintStatus.submitted,
      ),
      priority:
          ComplaintPriority.values.firstWhere(
        (e) => e.name == map["priority"],
        orElse: () =>
            ComplaintPriority.medium,
      ),
      departmentId: map["departmentId"],
      departmentName: map["departmentName"],
      assignedOfficerId:
          map["assignedOfficerId"],
      assignedOfficerName:
          map["assignedOfficerName"],
      aiDetected:
          map["aiDetected"] ?? false,
      aiPrediction:
          map["aiPrediction"],
      aiConfidence:
          map["aiConfidence"]?.toDouble(),
      createdAt:
          (map["createdAt"] as Timestamp)
              .toDate(),
      updatedAt: map["updatedAt"] == null
          ? null
          : (map["updatedAt"] as Timestamp)
              .toDate(),
      resolvedAt: map["resolvedAt"] == null
          ? null
          : (map["resolvedAt"] as Timestamp)
              .toDate(),
      isPublic: map["isPublic"] ?? true,
    );
  }

  //----------------------------------------
  // Snapshot
  //----------------------------------------

  factory ComplaintModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>>
        snapshot,
  ) {
    return ComplaintModel.fromMap(
      snapshot.data()!,
    );
  }
}