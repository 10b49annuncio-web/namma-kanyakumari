# Namma Kanyakumari (நம்ம கன்னியாகுமரி)

Official citizen grievance redressal, civic engagement, and public safety portal for Kanyakumari district, Tamil Nadu. Rewritten as a modern, high-performance React + TypeScript + Vite web application preserving all original features, models, routing, and design language.

## Key Features

- **Civic Issue Reporting**: Report hazards across Roads & Potholes, Street Lights, Water Supply, Drainage & Sanitation, Electricity Breakdown, and Public Parks with photo upload, GPS coordinates, Taluk selection, and severity level.
- **Complaint Tracking & Stepper**: Real-time lifecycle tracking (Submitted → Verified → Assigned → In Action → Resolved → Closed) with status chips and progress milestones.
- **24/7 Emergency Helplines**: Quick SOS dialer for District Police (100 / 112), 108 Ambulance, Fire & Rescue (101), District Disaster Management Authority (1077), Women Helpline (1091), Childline (1098), and Coastal Security Police (1093).
- **Administration & Public Directory**: Directory of District Collectorate, Municipalities, Taluk offices, and civic departments with direct phone, email, and handled categories.
- **Heritage & Tourism Guide**: Guide to Kanyakumari's iconic destinations including Vivekananda Rock Memorial, Thiruvalluvar Statue, Padmanabhapuram Palace, Mathur Aqueduct, and Vattakottai Fort with timings and visitor info.
- **Bilingual Support**: Instant toggle between English and Tamil (தமிழ்).
- **Dark Mode Support**: Seamless light/dark appearance toggle.
- **Local Persistence**: Client-side storage layer for user profiles, complaints, and notification state.

## Flutter Codebase Structure (`/flutter_project/`)

A complete Dart & Flutter application matching all 13 feature modules is available under `/flutter_project/`:

- `flutter_project/pubspec.yaml`: Full dependencies including `firebase_core`, `firebase_auth`, `cloud_firestore`, `firebase_storage`, `provider`, `shared_preferences`, `google_fonts`, `image_picker`, `url_launcher`.
- `flutter_project/lib/main.dart`: Root `NammaKanyakumariApp` with Material 3 theming (Deep Teal `#00695C`), light/dark modes, and multi-provider architecture.
- `flutter_project/lib/core/constants/`: `AppColors`, `AppStrings` (English & தமிழ் localization), `AppRoutes`.
- `flutter_project/lib/models/`: `UserModel`, `ComplaintModel`, `EmergencyContactModel`, `DepartmentModel`, `NotificationModel`.
- `flutter_project/lib/services/`: `AuthService` (Firebase Authentication), `FirestoreService` (Cloud Firestore with real-time streams), `StorageService`.
- `flutter_project/lib/providers/`: `AuthProvider`, `ComplaintProvider`, `ThemeProvider`.
- `flutter_project/lib/widgets/`: `StatusBadge`, `ComplaintCardWidget`, `CustomTextField`, `CustomButton`.
- `flutter_project/lib/screens/`: `LoginScreen`, `RegisterScreen`, `HomeScreen`, `ReportComplaintScreen`, `ComplaintHistoryScreen`, `ComplaintDetailsScreen`, `EmergencyScreen`, `ProfileScreen`.

To run the Flutter app locally:
```bash
cd flutter_project
flutter pub get
flutter run
```
