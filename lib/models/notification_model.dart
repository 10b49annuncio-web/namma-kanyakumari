import 'package:cloud_firestore/cloud_firestore.dart';

enum NotificationType {
  complaint,
  emergency,
  announcement,
  news,
  reminder,
  system,
}

class NotificationModel {
  final String notificationId;

  final String userId;

  final String title;
  final String body;

  final NotificationType type;

  final String? imageUrl;

  final String? complaintId;

  final String? deepLink;

  final bool isRead;

  final bool isDeleted;

  final DateTime createdAt;

  const NotificationModel({
    required this.notificationId,
    required this.userId,
    required this.title,
    required this.body,
    required this.type,
    required this.createdAt,
    this.imageUrl,
    this.complaintId,
    this.deepLink,
    this.isRead = false,
    this.isDeleted = false,
  });

  //--------------------------------------------------------
  // Empty
  //--------------------------------------------------------

  factory NotificationModel.empty() {
    return NotificationModel(
      notificationId: '',
      userId: '',
      title: '',
      body: '',
      type: NotificationType.system,
      createdAt: DateTime.now(),
    );
  }

  //--------------------------------------------------------
  // CopyWith
  //--------------------------------------------------------

  NotificationModel copyWith({
    String? notificationId,
    String? userId,
    String? title,
    String? body,
    NotificationType? type,
    String? imageUrl,
    String? complaintId,
    String? deepLink,
    bool? isRead,
    bool? isDeleted,
    DateTime? createdAt,
  }) {
    return NotificationModel(
      notificationId:
          notificationId ?? this.notificationId,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      imageUrl: imageUrl ?? this.imageUrl,
      complaintId:
          complaintId ?? this.complaintId,
      deepLink: deepLink ?? this.deepLink,
      isRead: isRead ?? this.isRead,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  //--------------------------------------------------------
  // To Map
  //--------------------------------------------------------

  Map<String, dynamic> toMap() {
    return {
      "notificationId": notificationId,
      "userId": userId,
      "title": title,
      "body": body,
      "type": type.name,
      "imageUrl": imageUrl,
      "complaintId": complaintId,
      "deepLink": deepLink,
      "isRead": isRead,
      "isDeleted": isDeleted,
      "createdAt":
          Timestamp.fromDate(createdAt),
    };
  }

  //--------------------------------------------------------
  // From Map
  //--------------------------------------------------------

  factory NotificationModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return NotificationModel(
      notificationId:
          map["notificationId"] ?? "",
      userId: map["userId"] ?? "",
      title: map["title"] ?? "",
      body: map["body"] ?? "",
      type: NotificationType.values.firstWhere(
        (e) => e.name == map["type"],
        orElse: () => NotificationType.system,
      ),
      imageUrl: map["imageUrl"],
      complaintId: map["complaintId"],
      deepLink: map["deepLink"],
      isRead: map["isRead"] ?? false,
      isDeleted: map["isDeleted"] ?? false,
      createdAt:
          (map["createdAt"] as Timestamp)
              .toDate(),
    );
  }

  //--------------------------------------------------------
  // From Snapshot
  //--------------------------------------------------------

  factory NotificationModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>>
        snapshot,
  ) {
    return NotificationModel.fromMap(
      snapshot.data()!,
    );
  }
}