import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/error_handling.dart';
import 'app_data.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  RegExp emailReg = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  //Register User
  Future<bool> register(
      {required String email,
      required String password,
      required String confirmPassword,
      required BuildContext context}) async {
    //make sure email and password are not empty
    if (email == '' || !emailReg.hasMatch(email)) {
      ErrorHandler().userAuthErrorMessage('invalid-email', context);
    } else if (password == '') {
      ErrorHandler().userAuthErrorMessage('invalid-password', context);
    } else if (password != confirmPassword) {
      ErrorHandler().userAuthErrorMessage('mismatch-password', context);
    } else {
      try {
        await _firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        return true;
      } on FirebaseAuthException catch (e) {
        ErrorHandler().userAuthErrorMessage(e as String, context);
        return false;
      }
    }
    return false;
  }

  //Login with Email and Password
  Future<bool> login(
      {required String email,
      required String password,
      required BuildContext context,
      required AppData data}) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      final user = userCredential.user;
      final uid = user?.uid ?? ''; //checks if user exists and if uid is null
      final authenticatedEmail =
          user?.email ?? ''; //checks if user exists and if email is null
      data.currentUser = AppUser(
        uid: uid,
        name: '',
        guest: false,
        email: authenticatedEmail,
        isAdmin: await AppData.isAdmin(uid),
      );
      //data.fetchEvents();
    } on FirebaseAuthException catch (e) {
      ErrorHandler().userAuthErrorMessage(e.code, context);
      return false;
    }
    return true;
  }

  //Login with Google account
  Future<bool> googleLogin(
      {required BuildContext context, required AppData data}) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      //Sign in to firebase with google credential
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final user = userCredential.user;
      final name =
          user?.displayName ?? ''; //checks if user exists and if name is null
      final uid = user?.uid ?? ''; //checks if user exists and if uid is null
      final authenticatedEmail =
          user?.email ?? ''; //checks if user exists and if email is null
      data.currentUser = AppUser(
        uid: uid,
        name: name,
        guest: false,
        email: authenticatedEmail,
        isAdmin: await AppData.isAdmin(uid),
      );
      AppData().fetchEvents();
    } on FirebaseAuthException catch (e) {
      ErrorHandler().userAuthErrorMessage(e.code, context);
      print(e);
      return false;
    } on PlatformException catch (e) {
      ErrorHandler().userAuthErrorMessage(e.code, context);
      print(e);
    }

    return true;
  }

  //Email password reset
  Future<bool> forgotPassword(
      {required String email, required BuildContext context}) async {
    if (email == '' || !emailReg.hasMatch(email)) {
      ErrorHandler().userAuthErrorMessage('invalid-email', context);
    } else {
      try {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
        return true;
      } on FirebaseAuthException catch (e) {
        ErrorHandler().userAuthErrorMessage(e.code, context);
        return false;
      }
    }
    return false;
  }

  //Logout
  Future logout() async {
    AppData().resetdata();
    await GoogleSignIn().signOut();
    await _firebaseAuth.signOut();
  }
}
