import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../models/complaint_model.dart';
import '../../providers/complaint_provider.dart';
import '../../widgets/custom_widgets.dart';

class ComplaintHistoryScreen extends StatefulWidget {
  const ComplaintHistoryScreen({Key? key}) : super(key: key);

  @override
  State<ComplaintHistoryScreen> createState() => _ComplaintHistoryScreenState();
}

class _ComplaintHistoryScreenState extends State<ComplaintHistoryScreen> {
  String _searchQuery = '';

  final List<Map<String, String>> _statusFilters = [
    {'id': 'all', 'label': 'All'},
    {'id': 'pending', 'label': 'Pending'},
    {'id': 'inProgress', 'label': 'In Action'},
    {'id': 'resolved', 'label': 'Resolved'},
    {'id': 'rejected', 'label': 'Rejected'},
    {'id': 'closed', 'label': 'Closed'},
  ];

  @override
  Widget build(BuildContext context) {
    final complaintProv = Provider.of<ComplaintProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final list = complaintProv.filteredComplaints.where((c) {
      if (_searchQuery.trim().isEmpty) return true;
      final q = _searchQuery.toLowerCase();
      return c.title.toLowerCase().contains(q) ||
          c.complaintId.toLowerCase().contains(q) ||
          c.category.toLowerCase().contains(q) ||
          c.address.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Grievance History'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search & Filter header
          Container(
            padding: const EdgeInsets.all(16),
            color: isDark ? AppColors.surfaceDark : Colors.white,
            child: Column(
              children: [
                TextField(
                  onChanged: (val) => setState(() => _searchQuery = val),
                  decoration: InputDecoration(
                    hintText: 'Search by ID, area, or category...',
                    prefixIcon: const Icon(Icons.search, size: 20),
                    filled: true,
                    fillColor: isDark ? Colors.black26 : Colors.grey[100],
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _statusFilters.map((st) {
                      final isSelected = complaintProv.statusFilter == st['id'];
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(st['label']!),
                          selected: isSelected,
                          selectedColor: AppColors.primary,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : (isDark ? Colors.white70 : Colors.black87),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          onSelected: (selected) {
                            if (selected) {
                              complaintProv.setFilter(st['id']!);
                            }
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Complaint Cards List
          Expanded(
            child: list.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.inbox_outlined, size: 48, color: Colors.grey[400]),
                          const SizedBox(height: 12),
                          const Text(
                            'No complaints found matching criteria',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: list.length,
                    itemBuilder: (ctx, idx) => ComplaintCardWidget(
                      complaint: list[idx],
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.complaintDetails,
                        arguments: list[idx],
                      ),
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.reportComplaint),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add),
        label: const Text('New Report'),
      ),
    );
  }
}
