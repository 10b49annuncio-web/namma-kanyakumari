import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/constants/app_colors.dart';
import 'core/constants/app_routes.dart';
import 'models/complaint_model.dart';
import 'providers/auth_provider.dart';
import 'providers/complaint_provider.dart';
import 'providers/theme_provider.dart';

import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/report_complaint_screen.dart';
import 'screens/complaint_history_screen.dart';
import 'screens/complaint_details_screen.dart';
import 'screens/emergency_screen.dart';
import 'screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase initialization notice: $e');
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ComplaintProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const NammaKanyakumariApp(),
    ),
  );
}

class NammaKanyakumariApp extends StatelessWidget {
  const NammaKanyakumariApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surfaceLight,
        brightness: Brightness.light,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        centerTitle: false,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );

    final darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surfaceDark,
        brightness: Brightness.dark,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: Colors.white,
        centerTitle: false,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );

    return MaterialApp(
      title: 'Namma Kanyakumari',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (ctx) => const LoginScreen(),
        AppRoutes.register: (ctx) => const RegisterScreen(),
        AppRoutes.home: (ctx) => const HomeScreen(),
        AppRoutes.reportComplaint: (ctx) => const ReportComplaintScreen(),
        AppRoutes.complaintHistory: (ctx) => const ComplaintHistoryScreen(),
        AppRoutes.emergency: (ctx) => const EmergencyScreen(),
        AppRoutes.profile: (ctx) => const ProfileScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.complaintDetails) {
          final complaint = settings.arguments as ComplaintModel;
          return MaterialPageRoute(
            builder: (ctx) => ComplaintDetailsScreen(complaint: complaint),
          );
        }
        return null;
      },
    );
  }
}
