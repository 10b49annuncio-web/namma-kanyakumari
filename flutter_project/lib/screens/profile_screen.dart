import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../providers/auth_provider.dart';
import '../../providers/theme_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final theme = Provider.of<ThemeProvider>(context);
    final user = auth.currentUser;
    final isDark = theme.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Citizen Profile'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Details Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: isDark ? Colors.white12 : Colors.black12),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: AppColors.primary,
                  child: Text(
                    user?.fullName.isNotEmpty == true ? user!.fullName[0].toUpperCase() : 'C',
                    style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.fullName ?? 'Citizen User',
                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        user?.email ?? 'citizen@kanyakumari.gov.in',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 14, color: AppColors.primary),
                          const SizedBox(width: 4),
                          Text(
                            '${user?.taluk ?? "Agastheeswaram"} Taluk',
                            style: const TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Settings Section
          const Text('Preferences & Language', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 10),

          Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: isDark ? Colors.white12 : Colors.black12),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Dark Appearance', style: TextStyle(fontSize: 14)),
                  subtitle: const Text('Night mode display', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  value: theme.isDarkMode,
                  activeColor: AppColors.primary,
                  onChanged: (_) => theme.toggleDarkMode(),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Language / மொழி', style: TextStyle(fontSize: 14)),
                  subtitle: Text(
                    theme.currentLanguage == 'ta' ? 'தமிழ் (Tamil)' : 'English',
                    style: const TextStyle(fontSize: 12, color: AppColors.primary),
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      final next = theme.currentLanguage == 'en' ? 'ta' : 'en';
                      theme.setLanguage(next);
                    },
                    child: Text(
                      theme.currentLanguage == 'en' ? 'Switch to தமிழ்' : 'Switch to ENG',
                      style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // About District Portal
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline, color: AppColors.primary, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'About Namma Kanyakumari',
                      style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  'Empowering citizens across Kanyakumari district with real-time grievance reporting, 24/7 disaster helpline coordination, and transparent governance.',
                  style: TextStyle(fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // Logout Button
          OutlinedButton.icon(
            onPressed: () async {
              await auth.logout();
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
              }
            },
            icon: const Icon(Icons.logout, color: Colors.red),
            label: const Text('Log Out', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.red),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
          ),
        ],
      ),
    );
  }
}
