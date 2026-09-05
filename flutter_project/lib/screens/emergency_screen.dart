import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';

class EmergencyContactItem {
  final String title;
  final String tamilTitle;
  final String number;
  final String department;
  final IconData icon;

  const EmergencyContactItem({
    required this.title,
    required this.tamilTitle,
    required this.number,
    required this.department,
    required this.icon,
  });
}

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({Key? key}) : super(key: key);

  final List<EmergencyContactItem> contacts = const [
    EmergencyContactItem(
      title: 'National Emergency Response (SOS)',
      tamilTitle: 'தேசிய அவசர உதவி எண்',
      number: '112',
      department: 'All Emergencies Unified Response',
      icon: Icons.shield,
    ),
    EmergencyContactItem(
      title: 'District Police Control Room',
      tamilTitle: 'காவல்துறை கட்டுப்பாட்டு அறை',
      number: '100',
      department: 'Kanyakumari District Police',
      icon: Icons.local_police,
    ),
    EmergencyContactItem(
      title: '108 Emergency Ambulance',
      tamilTitle: '108 அவசர ஆம்புலன்ஸ்',
      number: '108',
      department: 'Medical Trauma & Health Emergency',
      icon: Icons.local_hospital,
    ),
    EmergencyContactItem(
      title: 'Fire & Rescue Services',
      tamilTitle: 'தீயணைப்பு மற்றும் மீட்புப்பணி',
      number: '101',
      department: 'Fire Disaster Redressal',
      icon: Icons.local_fire_department,
    ),
    EmergencyContactItem(
      title: 'District Disaster Management (DDMA)',
      tamilTitle: 'மாவட்ட பேரிடர் மேலாண்மை',
      number: '1077',
      department: 'Kanyakumari Collectorate Flood/Cyclone Cell',
      icon: Icons.flood,
    ),
    EmergencyContactItem(
      title: 'Women Helpline (Domestic/Safety)',
      tamilTitle: 'பெண்கள் உதவி எண்',
      number: '1091',
      department: 'State Women Welfare Helpline',
      icon: Icons.support_agent,
    ),
    EmergencyContactItem(
      title: 'Childline 24/7 Support',
      tamilTitle: 'குழந்தைகள் உதவி எண்',
      number: '1098',
      department: 'Child Rights & Protection',
      icon: Icons.child_care,
    ),
    EmergencyContactItem(
      title: 'Coastal Security Police',
      tamilTitle: 'கடலோர பாதுகாப்புக் குழுமம்',
      number: '1093',
      department: 'Marine Safety & Sea Rescues',
      icon: Icons.sailing,
    ),
    EmergencyContactItem(
      title: 'TANGEDCO Electricity Breakdown',
      tamilTitle: 'மின்சார வாரிய புகார் மையம்',
      number: '1912',
      department: 'Power Failure & Transformer Spark',
      icon: Icons.electric_bolt,
    ),
  ];

  void _callNumber(String num) async {
    final uri = Uri.parse('tel:$num');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('District Emergency Helplines'),
        backgroundColor: AppColors.emergencyRed,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Banner
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.emergencyRed,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, color: Colors.white, size: 28),
                    SizedBox(width: 8),
                    Text(
                      '24/7 Speed Dial Response',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  'Tap on any service below for instant toll-free dialing to first responders across Kanyakumari district.',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          ...contacts.map((c) => Card(
                elevation: 0.5,
                margin: const EdgeInsets.only(bottom: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: isDark ? Colors.white12 : Colors.black12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primary.withOpacity(0.12),
                    child: Icon(c.icon, color: AppColors.primary),
                  ),
                  title: Text(
                    c.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(c.tamilTitle, style: const TextStyle(fontSize: 11, color: AppColors.primary)),
                      Text(c.department, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                  trailing: ElevatedButton.icon(
                    onPressed: () => _callNumber(c.number),
                    icon: const Icon(Icons.call, size: 16),
                    label: Text(c.number),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.emergencyRed,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
