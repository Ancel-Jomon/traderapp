import 'package:firebase_auth/firebase_auth.dart';

class FirebaseEmailVerification {
  final user = FirebaseAuth.instance.currentUser;
  void sendVerificationEmail() async {
    await user!.sendEmailVerification();
  }

  Future<bool> checkEmailVerification() async {
    await user!.reload();
    return FirebaseAuth.instance.currentUser!.emailVerified;
  }
}
