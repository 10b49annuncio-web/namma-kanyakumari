import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Current Firebase User
  User? get currentUser => _auth.currentUser;

  // Register with Email & Password + Save Profile to Firestore
  Future<UserModel> registerWithEmail({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    required String taluk,
    required String village,
    required String pincode,
  }) async {
    try {
      final UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final User? firebaseUser = credential.user;
      if (firebaseUser == null) {
        throw Exception('User creation failed');
      }

      // Send email verification
      await firebaseUser.sendEmailVerification();

      // Create UserModel in Firestore 'users' collection
      final UserModel newUser = UserModel(
        uid: firebaseUser.uid,
        fullName: fullName.trim(),
        email: email.trim(),
        phoneNumber: phoneNumber.trim(),
        taluk: taluk,
        village: village.trim(),
        pincode: pincode.trim(),
        isEmailVerified: false,
        createdAt: DateTime.now(),
      );

      await _firestore.collection('users').doc(firebaseUser.uid).set(newUser.toMap());
      return newUser;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('Registration error: ${e.toString()}');
    }
  }

  // Sign In with Email and Password
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final User? firebaseUser = credential.user;
      if (firebaseUser == null) {
        throw Exception('Sign in failed');
      }

      // Fetch user profile from Firestore
      final DocumentSnapshot doc =
          await _firestore.collection('users').doc(firebaseUser.uid).get();

      if (doc.exists && doc.data() != null) {
        final data = doc.data() as Map<String, dynamic>;
        return UserModel.fromMap(data, firebaseUser.uid).copyWith(
          isEmailVerified: firebaseUser.emailVerified,
        );
      } else {
        // Fallback profile if record is fresh
        final UserModel fallbackUser = UserModel(
          uid: firebaseUser.uid,
          fullName: firebaseUser.displayName ?? 'Citizen',
          email: firebaseUser.email ?? email,
          phoneNumber: firebaseUser.phoneNumber ?? '',
          taluk: 'Agastheeswaram',
          village: 'Nagercoil',
          pincode: '629001',
          isEmailVerified: firebaseUser.emailVerified,
          createdAt: DateTime.now(),
        );
        await _firestore.collection('users').doc(firebaseUser.uid).set(fallbackUser.toMap());
        return fallbackUser;
      }
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('Authentication error: ${e.toString()}');
    }
  }

  // Send Password Reset Email
  Future<void> sendPasswordReset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Resend Email Verification
  Future<void> resendVerificationEmail() async {
    final user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Translate Firebase Auth error codes into human-readable messages
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No citizen profile found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please verify your credentials.';
      case 'email-already-in-use':
        return 'An account already exists with this email address.';
      case 'invalid-email':
        return 'The email address format is invalid.';
      case 'weak-password':
        return 'Password must be at least 6 characters with strong entropy.';
      case 'user-disabled':
        return 'This citizen account has been suspended by district administration.';
      case 'too-many-requests':
        return 'Too many login attempts. Please try again after some time.';
      default:
        return e.message ?? 'An authentication error occurred.';
    }
  }
}
