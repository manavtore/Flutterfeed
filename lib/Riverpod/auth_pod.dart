import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfeed/network/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  bool isloading = false;
  UserCredential? _userCredential;
  Map<String, dynamic> _userDate = {};
  FirebaseAuthClass auth = FirebaseAuthClass();
  UserCredential? get userCredential => _userCredential;
  Map<String, dynamic> get UserData => _userDate;

  Future<UserCredential> loginUserWithFirebase(
      String email, String password) async {
    SetLoader(true);
    try {
      _userCredential = await auth.loginUserWithFirebase(email, password);
      SetLoader(false);
      return _userCredential!;
    } catch (e) {
      SetLoader(false);
      throw e;
    }
  }

  SetLoader(bool loader) {
    isloading = loader;
    notifyListeners();
  }

  Future<UserCredential> signupUserWithFirebase(
      String email, String password, String name) async {
    SetLoader(true);
    try {
      _userCredential =
          await auth.signupUserWithFirebase(email, password, name);
      SetLoader(false);
      return _userCredential!;
    } catch (e) {
      SetLoader(false);
      throw e;
    }
  }
}
