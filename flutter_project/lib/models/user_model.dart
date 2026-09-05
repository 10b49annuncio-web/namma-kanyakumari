import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String role; // 'citizen', 'officer', 'admin'
  final String taluk;
  final String village;
  final String pincode;
  final bool isEmailVerified;
  final DateTime createdAt;
  final DateTime? updatedAt;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    this.role = 'citizen',
    required this.taluk,
    required this.village,
    required this.pincode,
    this.isEmailVerified = false,
    required this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> data, String id) {
    return UserModel(
      uid: id,
      fullName: data['fullName'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      role: data['role'] ?? 'citizen',
      taluk: data['taluk'] ?? 'Agastheeswaram',
      village: data['village'] ?? 'Nagercoil',
      pincode: data['pincode'] ?? '629001',
      isEmailVerified: data['isEmailVerified'] ?? false,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'role': role,
      'taluk': taluk,
      'village': village,
      'pincode': pincode,
      'isEmailVerified': isEmailVerified,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }

  UserModel copyWith({
    String? fullName,
    String? phoneNumber,
    String? taluk,
    String? village,
    String? pincode,
    bool? isEmailVerified,
  }) {
    return UserModel(
      uid: uid,
      fullName: fullName ?? this.fullName,
      email: email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role,
      taluk: taluk ?? this.taluk,
      village: village ?? this.village,
      pincode: pincode ?? this.pincode,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }
}
