import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole {
  citizen,
  officer,
  admin,
}

class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String? profileImage;

  final UserRole role;

  final bool isVerified;
  final bool isActive;

  final String? address;
  final String? district;
  final String? taluk;
  final String? village;
  final String? pincode;

  final DateTime createdAt;
  final DateTime? updatedAt;

  const UserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.createdAt,
    this.profileImage,
    this.address,
    this.district,
    this.taluk,
    this.village,
    this.pincode,
    this.updatedAt,
    this.isVerified = false,
    this.isActive = true,
  });

  //------------------------------------------
  // Empty User
  //------------------------------------------

  factory UserModel.empty() {
    return UserModel(
      uid: '',
      fullName: '',
      email: '',
      phoneNumber: '',
      role: UserRole.citizen,
      createdAt: DateTime.now(),
    );
  }

  //------------------------------------------
  // Copy With
  //------------------------------------------

  UserModel copyWith({
    String? uid,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? profileImage,
    UserRole? role,
    bool? isVerified,
    bool? isActive,
    String? address,
    String? district,
    String? taluk,
    String? village,
    String? pincode,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImage: profileImage ?? this.profileImage,
      role: role ?? this.role,
      isVerified: isVerified ?? this.isVerified,
      isActive: isActive ?? this.isActive,
      address: address ?? this.address,
      district: district ?? this.district,
      taluk: taluk ?? this.taluk,
      village: village ?? this.village,
      pincode: pincode ?? this.pincode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  //------------------------------------------
  // To Firestore
  //------------------------------------------

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "fullName": fullName,
      "email": email,
      "phoneNumber": phoneNumber,
      "profileImage": profileImage,
      "role": role.name,
      "isVerified": isVerified,
      "isActive": isActive,
      "address": address,
      "district": district,
      "taluk": taluk,
      "village": village,
      "pincode": pincode,
      "createdAt": Timestamp.fromDate(createdAt),
      "updatedAt":
          updatedAt == null ? null : Timestamp.fromDate(updatedAt!),
    };
  }

  //------------------------------------------
  // From Firestore
  //------------------------------------------

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map["uid"] ?? "",
      fullName: map["fullName"] ?? "",
      email: map["email"] ?? "",
      phoneNumber: map["phoneNumber"] ?? "",
      profileImage: map["profileImage"],
      role: UserRole.values.firstWhere(
        (e) => e.name == map["role"],
        orElse: () => UserRole.citizen,
      ),
      isVerified: map["isVerified"] ?? false,
      isActive: map["isActive"] ?? true,
      address: map["address"],
      district: map["district"],
      taluk: map["taluk"],
      village: map["village"],
      pincode: map["pincode"],
      createdAt:
          (map["createdAt"] as Timestamp).toDate(),
      updatedAt: map["updatedAt"] == null
          ? null
          : (map["updatedAt"] as Timestamp).toDate(),
    );
  }

  //------------------------------------------
  // Firestore Snapshot
  //------------------------------------------

  factory UserModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data()!;

    return UserModel.fromMap(data);
  }
}