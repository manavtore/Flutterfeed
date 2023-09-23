import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseFirebaseService {
  Future<UserCredential> loginUserWithFirebase(String email, String password);

  void signOutUser();

  bool isUserlogin();
}
