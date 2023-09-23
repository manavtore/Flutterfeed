import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfeed/network/abstract/base_firebase_service.dart';

class FirebaseAuthClass extends BaseFirebaseService {
  final auth = FirebaseAuth.instance;
  @override
  bool isUserlogin() {
    if (auth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<UserCredential> loginUserWithFirebase(String email, String password) {
    final UserCredential =
        auth.signInWithEmailAndPassword(email: email, password: password);
    return UserCredential;
  }

  @override
  void signOutUser() {
    auth.signOut();
  }

  Future<UserCredential> signupUserWithFirebase(
      String email, String password, String name) {
    final UserCredential =
        auth.createUserWithEmailAndPassword(email: email, password: password);

    return UserCredential;
  }
}
