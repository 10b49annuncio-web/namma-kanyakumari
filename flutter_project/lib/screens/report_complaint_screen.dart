import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../models/complaint_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/complaint_provider.dart';
import '../../widgets/custom_widgets.dart';

class ReportComplaintScreen extends StatefulWidget {
  const ReportComplaintScreen({Key? key}) : super(key: key);

  @override
  State<ReportComplaintScreen> createState() => _ReportComplaintScreenState();
}

class _ReportComplaintScreenState extends State<ReportComplaintScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController();
  final _villageController = TextEditingController();

  String _category = 'Roads & Potholes';
  String _taluk = 'Agastheeswaram';
  ComplaintPriority _priority = ComplaintPriority.medium;
  List<File> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  final List<String> _categories = [
    'Roads & Potholes',
    'Street Light Breakdown',
    'Water Supply Shortage',
    'Drainage & Sanitation',
    'Electricity Breakdown',
    'Garbage & Cleanliness',
    'Public Parks & Trees',
  ];

  final List<String> _taluks = [
    'Agastheeswaram',
    'Thovalai',
    'Kalkulam',
    'Vilavancode',
    'Thiruvattar',
    'Killiyoor',
  ];

  @override
  void initState() {
    super.initState();
    final user = Provider.of<AuthProvider>(context, listen: false).currentUser;
    if (user != null) {
      _taluk = user.taluk;
      _villageController.text = user.village;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _addressController.dispose();
    _villageController.dispose();
    super.dispose();
  }

  void _pickImage(ImageSource source) async {
    try {
      final picked = await _picker.pickImage(source: source, imageQuality: 75);
      if (picked != null) {
        setState(() {
          _selectedImages.add(File(picked.path));
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  void _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final user = Provider.of<AuthProvider>(context, listen: false).currentUser;
    if (user == null) return;

    final complaintProv = Provider.of<ComplaintProvider>(context, listen: false);
    final complaintId = await complaintProv.submitComplaint(
      citizenId: user.uid,
      citizenName: user.fullName,
      citizenPhone: user.phoneNumber,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      category: _category,
      departmentId: _mapCategoryToDepartment(_category),
      priority: _priority,
      address: _addressController.text.trim(),
      taluk: _taluk,
      village: _villageController.text.trim(),
      images: _selectedImages,
    );

    if (complaintId != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Grievance filed successfully! Ref: $complaintId'),
          backgroundColor: AppColors.statusResolved,
        ),
      );
      Navigator.pop(context);
    } else if (complaintProv.errorMessage != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(complaintProv.errorMessage!),
          backgroundColor: AppColors.emergencyRed,
        ),
      );
    }
  }

  String _mapCategoryToDepartment(String cat) {
    if (cat.contains('Road')) return 'highways';
    if (cat.contains('Light') || cat.contains('Electricity')) return 'tneb';
    if (cat.contains('Water')) return 'twad';
    return 'municipality';
  }

  @override
  Widget build(BuildContext context) {
    final complaintProv = Provider.of<ComplaintProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Civic Grievance'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Selector
              const Text('Issue Category', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.category_outlined, color: AppColors.primary),
                  filled: true,
                  fillColor: isDark ? AppColors.surfaceDark : Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
                items: _categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c, style: const TextStyle(fontSize: 13))))
                    .toList(),
                onChanged: (v) {
                  if (v != null) setState(() => _category = v);
                },
              ),
              const SizedBox(height: 16),

              // Title
              CustomTextField(
                controller: _titleController,
                label: 'Issue Headline / Summary',
                hint: 'e.g. Major water pipeline leak near beach road',
                prefixIcon: Icons.title,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter a title' : null,
              ),
              const SizedBox(height: 16),

              // Description
              CustomTextField(
                controller: _descriptionController,
                label: 'Detailed Description',
                hint: 'Describe the issue, landmarks, hazard level...',
                maxLines: 4,
                validator: (v) => (v == null || v.length < 10) ? 'Provide at least 10 characters' : null,
              ),
              const SizedBox(height: 16),

              // Location: Taluk & Village
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _taluk,
                      decoration: InputDecoration(
                        labelText: 'Taluk',
                        filled: true,
                        fillColor: isDark ? AppColors.surfaceDark : Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      items: _taluks
                          .map((t) => DropdownMenuItem(value: t, child: Text(t, style: const TextStyle(fontSize: 12))))
                          .toList(),
                      onChanged: (v) {
                        if (v != null) setState(() => _taluk = v);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomTextField(
                      controller: _villageController,
                      label: 'Town / Village',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Landmark address
              CustomTextField(
                controller: _addressController,
                label: 'Specific Street / Landmark Address',
                hint: 'Near Government Hospital, Opp. Bus Stop',
                prefixIcon: Icons.pin_drop_outlined,
                validator: (v) => (v == null || v.isEmpty) ? 'Please enter address' : null,
              ),
              const SizedBox(height: 20),

              // Photo Evidence
              const Text('Photo Evidence (Optional)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 8),
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: () => _pickImage(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt, color: AppColors.primary, size: 18),
                    label: const Text('Camera', style: TextStyle(color: AppColors.primary)),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  OutlinedButton.icon(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library, color: AppColors.primary, size: 18),
                    label: const Text('Gallery', style: TextStyle(color: AppColors.primary)),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              if (_selectedImages.isNotEmpty)
                SizedBox(
                  height: 90,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _selectedImages.length,
                    itemBuilder: (ctx, idx) => Stack(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: FileImage(_selectedImages[idx]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 2,
                          right: 12,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedImages.removeAt(idx);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.close, size: 14, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 28),

              // Submit Button
              CustomButton(
                title: 'Submit Grievance to Administration',
                onPressed: _handleSubmit,
                isLoading: complaintProv.isLoading,
                icon: Icons.send,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
