import 'package:firebase_auth/firebase_auth.dart';

class UserController {
  static Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<User?> getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  static Future<String?> getCurrentUserId() async {
    final user = await getCurrentUser();
    return user?.uid;
  }
}
