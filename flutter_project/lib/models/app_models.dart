class EmergencyContactModel {
  final String id;
  final String title;
  final String tamilTitle;
  final String category; // 'police', 'ambulance', 'fire', 'disaster', 'women', 'coastal'
  final String phoneNumber;
  final String description;
  final bool isTollFree;
  final String iconName;

  EmergencyContactModel({
    required this.id,
    required this.title,
    required this.tamilTitle,
    required this.category,
    required this.phoneNumber,
    required this.description,
    this.isTollFree = true,
    required this.iconName,
  });

  factory EmergencyContactModel.fromMap(Map<String, dynamic> data, String id) {
    return EmergencyContactModel(
      id: id,
      title: data['title'] ?? '',
      tamilTitle: data['tamilTitle'] ?? '',
      category: data['category'] ?? 'police',
      phoneNumber: data['phoneNumber'] ?? '',
      description: data['description'] ?? '',
      isTollFree: data['isTollFree'] ?? true,
      iconName: data['iconName'] ?? 'phone',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'tamilTitle': tamilTitle,
      'category': category,
      'phoneNumber': phoneNumber,
      'description': description,
      'isTollFree': isTollFree,
      'iconName': iconName,
    };
  }
}

class DepartmentModel {
  final String departmentId;
  final String name;
  final String tamilName;
  final String officerInCharge;
  final String phoneNumber;
  final String email;
  final String officeAddress;
  final List<String> handledCategories;

  DepartmentModel({
    required this.departmentId,
    required this.name,
    required this.tamilName,
    required this.officerInCharge,
    required this.phoneNumber,
    required this.email,
    required this.officeAddress,
    required this.handledCategories,
  });

  factory DepartmentModel.fromMap(Map<String, dynamic> data, String id) {
    return DepartmentModel(
      departmentId: id,
      name: data['name'] ?? '',
      tamilName: data['tamilName'] ?? '',
      officerInCharge: data['officerInCharge'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      email: data['email'] ?? '',
      officeAddress: data['officeAddress'] ?? '',
      handledCategories: List<String>.from(data['handledCategories'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'tamilName': tamilName,
      'officerInCharge': officerInCharge,
      'phoneNumber': phoneNumber,
      'email': email,
      'officeAddress': officeAddress,
      'handledCategories': handledCategories,
    };
  }
}

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String type; // 'complaint', 'emergency', 'announcement'
  final bool isRead;
  final DateTime timestamp;
  final String? complaintId;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    this.isRead = false,
    required this.timestamp,
    this.complaintId,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> data, String id) {
    return NotificationModel(
      id: id,
      title: data['title'] ?? '',
      body: data['body'] ?? '',
      type: data['type'] ?? 'announcement',
      isRead: data['isRead'] ?? false,
      timestamp: (data['timestamp'] as dynamic)?.toDate() ?? DateTime.now(),
      complaintId: data['complaintId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'type': type,
      'isRead': isRead,
      'timestamp': timestamp,
      'complaintId': complaintId,
    };
  }
}
