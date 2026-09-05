import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("FixNear"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const SizedBox(height: 20),

            const CircleAvatar(
              radius: 45,
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              user?.displayName ?? "User",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              user?.email ?? "",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 40),

            Card(
              child: ListTile(
                leading: const Icon(Icons.home_repair_service),
                title: const Text("Book a Service"),
                subtitle: const Text("Electrician, Plumber, AC Repair"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to service screen
                },
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.history),
                title: const Text("Booking History"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to booking history
                },
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Profile"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to profile
                },
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => logout(context),
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}