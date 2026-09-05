import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../providers/auth_provider.dart';
import '../../providers/complaint_provider.dart';
import '../../widgets/custom_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = Provider.of<AuthProvider>(context, listen: false).currentUser;
      if (user != null) {
        Provider.of<ComplaintProvider>(context, listen: false)
            .listenToCitizenComplaints(user.uid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).currentUser;
    final complaintProv = Provider.of<ComplaintProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Namma Kanyakumari',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              user?.taluk != null ? '${user!.taluk} Taluk' : 'District Administration',
              style: const TextStyle(fontSize: 11, color: Colors.white70),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.notifications),
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.profile),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Banner & SOS direct alert
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Vanakkam, ${user?.fullName ?? "Citizen"}!',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.verified_user, color: Colors.white, size: 14),
                            SizedBox(width: 4),
                            Text('Verified', style: TextStyle(color: Colors.white, fontSize: 11)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Report municipal problems, track departmental action, and access 24/7 disaster helplines.',
                    style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.4),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () =>
                              Navigator.pushNamed(context, AppRoutes.reportComplaint),
                          icon: const Icon(Icons.add_circle_outline, size: 18),
                          label: const Text('New Complaint', style: TextStyle(fontSize: 13)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.primaryDark,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: () => Navigator.pushNamed(context, AppRoutes.emergency),
                        icon: const Icon(Icons.phone_in_talk, size: 18, color: Colors.white),
                        label: const Text('SOS Dial', style: TextStyle(color: Colors.white, fontSize: 13)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.emergencyRed,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // District Department Shortcuts
            const Text(
              'Quick District Services',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                _buildServiceTile(Icons.traffic, 'Roads', AppColors.primary, () {
                  Navigator.pushNamed(context, AppRoutes.reportComplaint);
                }),
                _buildServiceTile(Icons.lightbulb_outline, 'Lights', Colors.amber[700]!, () {
                  Navigator.pushNamed(context, AppRoutes.reportComplaint);
                }),
                _buildServiceTile(Icons.water_drop_outlined, 'Water', Colors.blue[600]!, () {
                  Navigator.pushNamed(context, AppRoutes.reportComplaint);
                }),
                _buildServiceTile(Icons.delete_outline, 'Waste', Colors.teal[700]!, () {
                  Navigator.pushNamed(context, AppRoutes.reportComplaint);
                }),
                _buildServiceTile(Icons.local_hospital_outlined, '108 Help', Colors.red[600]!, () {
                  Navigator.pushNamed(context, AppRoutes.emergency);
                }),
                _buildServiceTile(Icons.security, 'Police', Colors.indigo[600]!, () {
                  Navigator.pushNamed(context, AppRoutes.emergency);
                }),
                _buildServiceTile(Icons.account_balance, 'Collectorate', Colors.purple[600]!, () {
                  Navigator.pushNamed(context, AppRoutes.departmentDirectory);
                }),
                _buildServiceTile(Icons.map, 'Tourism', Colors.orange[700]!, () {
                  Navigator.pushNamed(context, AppRoutes.departmentDirectory);
                }),
              ],
            ),
            const SizedBox(height: 24),

            // Active Complaints Overview
            Row(
              mainAxisAlignment: MainAxisAlignment.between,
              children: [
                const Text(
                  'My Reported Grievances',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.complaintHistory),
                  child: const Text('View All', style: TextStyle(color: AppColors.primary)),
                ),
              ],
            ),
            const SizedBox(height: 8),

            if (complaintProv.isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              )
            else if (complaintProv.complaints.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
                ),
                child: Column(
                  children: [
                    Icon(Icons.assignment_turned_in_outlined, size: 48, color: Colors.grey[400]),
                    const SizedBox(height: 12),
                    const Text(
                      'No grievances filed yet',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Have an issue with roads, streetlights, or drainage? File a report now.',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 14),
                    ElevatedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, AppRoutes.reportComplaint),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Report an Issue'),
                    ),
                  ],
                ),
              )
            else
              ...complaintProv.complaints.take(3).map(
                    (c) => ComplaintCardWidget(
                      complaint: c,
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.complaintDetails,
                        arguments: c,
                      ),
                    ),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentNavIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (idx) {
          setState(() => _currentNavIndex = idx);
          if (idx == 1) Navigator.pushNamed(context, AppRoutes.complaintHistory);
          if (idx == 2) Navigator.pushNamed(context, AppRoutes.emergency);
          if (idx == 3) Navigator.pushNamed(context, AppRoutes.profile);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Complaints'),
          BottomNavigationBarItem(icon: Icon(Icons.phone), label: 'Emergency'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildServiceTile(
      IconData icon, String title, Color color, VoidCallback onTap) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isDark ? Colors.white10 : Colors.black.withOpacity(0.06)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white70 : Colors.black80,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
