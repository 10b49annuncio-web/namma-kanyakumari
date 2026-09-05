import 'package:cloud_firestore/cloud_firestore.dart';

enum EmergencyType {
  police,
  ambulance,
  fire,
  disaster,
  hospital,
  women,
  child,
  electricity,
  water,
  traffic,
  coastGuard,
  other,
}

class EmergencyModel {
  final String id;

  final String name;
  final String description;

  final EmergencyType type;

  final String phoneNumber;

  final String? alternatePhone;

  final String address;

  final double latitude;
  final double longitude;

  final String icon;

  final bool is24Hours;

  final bool isActive;

  final DateTime createdAt;

  final DateTime? updatedAt;

  const EmergencyModel({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.phoneNumber,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.icon,
    required this.createdAt,
    this.alternatePhone,
    this.updatedAt,
    this.is24Hours = true,
    this.isActive = true,
  });

  //------------------------------------------
  // Empty
  //------------------------------------------

  factory EmergencyModel.empty() {
    return EmergencyModel(
      id: '',
      name: '',
      description: '',
      type: EmergencyType.other,
      phoneNumber: '',
      address: '',
      latitude: 0,
      longitude: 0,
      icon: '',
      createdAt: DateTime.now(),
    );
  }

  //------------------------------------------
  // CopyWith
  //------------------------------------------

  EmergencyModel copyWith({
    String? id,
    String? name,
    String? description,
    EmergencyType? type,
    String? phoneNumber,
    String? alternatePhone,
    String? address,
    double? latitude,
    double? longitude,
    String? icon,
    bool? is24Hours,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return EmergencyModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      alternatePhone:
          alternatePhone ?? this.alternatePhone,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      icon: icon ?? this.icon,
      is24Hours: is24Hours ?? this.is24Hours,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  //------------------------------------------
  // To Map
  //------------------------------------------

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "type": type.name,
      "phoneNumber": phoneNumber,
      "alternatePhone": alternatePhone,
      "address": address,
      "latitude": latitude,
      "longitude": longitude,
      "icon": icon,
      "is24Hours": is24Hours,
      "isActive": isActive,
      "createdAt": Timestamp.fromDate(createdAt),
      "updatedAt": updatedAt == null
          ? null
          : Timestamp.fromDate(updatedAt!),
    };
  }

  //------------------------------------------
  // From Map
  //------------------------------------------

  factory EmergencyModel.fromMap(
      Map<String, dynamic> map) {
    return EmergencyModel(
      id: map["id"] ?? "",
      name: map["name"] ?? "",
      description: map["description"] ?? "",
      type: EmergencyType.values.firstWhere(
        (e) => e.name == map["type"],
        orElse: () => EmergencyType.other,
      ),
      phoneNumber: map["phoneNumber"] ?? "",
      alternatePhone: map["alternatePhone"],
      address: map["address"] ?? "",
      latitude: (map["latitude"] ?? 0).toDouble(),
      longitude:
          (map["longitude"] ?? 0).toDouble(),
      icon: map["icon"] ?? "",
      is24Hours: map["is24Hours"] ?? true,
      isActive: map["isActive"] ?? true,
      createdAt:
          (map["createdAt"] as Timestamp).toDate(),
      updatedAt: map["updatedAt"] == null
          ? null
          : (map["updatedAt"] as Timestamp).toDate(),
    );
  }

  //------------------------------------------
  // Snapshot
  //------------------------------------------

  factory EmergencyModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>>
        snapshot,
  ) {
    return EmergencyModel.fromMap(
      snapshot.data()!,
    );
  }
}