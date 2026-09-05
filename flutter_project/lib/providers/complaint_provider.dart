import 'dart:io';
import 'package:flutter/material.dart';
import '../models/complaint_model.dart';
import '../services/firestore_service.dart';

class ComplaintProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  List<ComplaintModel> _complaints = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _statusFilter = 'all';

  List<ComplaintModel> get complaints => _complaints;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get statusFilter => _statusFilter;

  List<ComplaintModel> get filteredComplaints {
    if (_statusFilter == 'all') {
      return _complaints;
    }
    return _complaints.where((c) => c.status.name == _statusFilter).toList();
  }

  void setFilter(String filter) {
    _statusFilter = filter;
    notifyListeners();
  }

  void listenToCitizenComplaints(String citizenId) {
    _isLoading = true;
    notifyListeners();

    _firestoreService.streamCitizenComplaints(citizenId).listen((data) {
      _complaints = data;
      _isLoading = false;
      notifyListeners();
    }, onError: (err) {
      _isLoading = false;
      _errorMessage = err.toString();
      notifyListeners();
    });
  }

  Future<String?> submitComplaint({
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
    List<File> images = const [],
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final complaintId = await _firestoreService.submitComplaint(
        citizenId: citizenId,
        citizenName: citizenName,
        citizenPhone: citizenPhone,
        title: title,
        description: description,
        category: category,
        departmentId: departmentId,
        priority: priority,
        address: address,
        taluk: taluk,
        village: village,
        latitude: latitude,
        longitude: longitude,
        imageFiles: images,
      );
      _isLoading = false;
      notifyListeners();
      return complaintId;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }
}
