import 'package:cloud_firestore/cloud_firestore.dart';

class DepartmentModel {
  final String departmentId;

  final String name;
  final String description;

  final String icon;

  final String phoneNumber;
  final String email;

  final String officeAddress;

  final bool isActive;

  final int totalOfficers;

  final List<String> complaintCategories;

  final DateTime createdAt;
  final DateTime? updatedAt;

  const DepartmentModel({
    required this.departmentId,
    required this.name,
    required this.description,
    required this.icon,
    required this.phoneNumber,
    required this.email,
    required this.officeAddress,
    required this.complaintCategories,
    required this.totalOfficers,
    required this.createdAt,
    this.updatedAt,
    this.isActive = true,
  });

  //----------------------------------------------------
  // Empty
  //----------------------------------------------------

  factory DepartmentModel.empty() {
    return DepartmentModel(
      departmentId: '',
      name: '',
      description: '',
      icon: '',
      phoneNumber: '',
      email: '',
      officeAddress: '',
      complaintCategories: [],
      totalOfficers: 0,
      createdAt: DateTime.now(),
    );
  }

  //----------------------------------------------------
  // CopyWith
  //----------------------------------------------------

  DepartmentModel copyWith({
    String? departmentId,
    String? name,
    String? description,
    String? icon,
    String? phoneNumber,
    String? email,
    String? officeAddress,
    bool? isActive,
    int? totalOfficers,
    List<String>? complaintCategories,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DepartmentModel(
      departmentId: departmentId ?? this.departmentId,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      officeAddress: officeAddress ?? this.officeAddress,
      isActive: isActive ?? this.isActive,
      totalOfficers: totalOfficers ?? this.totalOfficers,
      complaintCategories:
          complaintCategories ?? this.complaintCategories,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  //----------------------------------------------------
  // To Map
  //----------------------------------------------------

  Map<String, dynamic> toMap() {
    return {
      "departmentId": departmentId,
      "name": name,
      "description": description,
      "icon": icon,
      "phoneNumber": phoneNumber,
      "email": email,
      "officeAddress": officeAddress,
      "isActive": isActive,
      "totalOfficers": totalOfficers,
      "complaintCategories": complaintCategories,
      "createdAt": Timestamp.fromDate(createdAt),
      "updatedAt": updatedAt == null
          ? null
          : Timestamp.fromDate(updatedAt!),
    };
  }

  //----------------------------------------------------
  // From Map
  //----------------------------------------------------

  factory DepartmentModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return DepartmentModel(
      departmentId: map["departmentId"] ?? "",
      name: map["name"] ?? "",
      description: map["description"] ?? "",
      icon: map["icon"] ?? "",
      phoneNumber: map["phoneNumber"] ?? "",
      email: map["email"] ?? "",
      officeAddress: map["officeAddress"] ?? "",
      isActive: map["isActive"] ?? true,
      totalOfficers: map["totalOfficers"] ?? 0,
      complaintCategories: List<String>.from(
        map["complaintCategories"] ?? [],
      ),
      createdAt:
          (map["createdAt"] as Timestamp).toDate(),
      updatedAt: map["updatedAt"] == null
          ? null
          : (map["updatedAt"] as Timestamp).toDate(),
    );
  }

  //----------------------------------------------------
  // From Snapshot
  //----------------------------------------------------

  factory DepartmentModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    return DepartmentModel.fromMap(snapshot.data()!);
  }
}