import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newcap/colors.dart';
import 'package:newcap/home.dart';
import 'package:newcap/signup_email_password_fail.dart';
import 'package:newcap/wellcome.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const Wellcome())
        : Get.offAll(() => const HomePage());
  }

  Future<void> createUserWithEmailAndPassword(
      String userEmail, String userPass, String userName, String phoneNo) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: userEmail, password: userPass,);
      firebaseUser.value != null
          ? Get.offAll(() => const HomePage())
          : Get.to(() => const Wellcome());
          
    } on FirebaseAuthException catch (e) {
    Get.snackbar("About user", "User message",
    
    backgroundColor: Colors.pink,
    snackPosition: SnackPosition.BOTTOM,
    titleText: Text("Account creation failed",
    style: TextStyle(
      color: Colors.white 
    ),),
    messageText: Text(
      e.toString(),
      style: TextStyle(
        color: Colors.white
      ),
    )
    );
    }
  }
   Future<void> signInWithEmailAndPassword(
      String userEmail, String userPass, ) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: userEmail, password: userPass);
    
    }  on FirebaseAuthException catch (e) {
       Get.snackbar("About Login", "Login message",
    
    backgroundColor: Colors.pink,
    snackPosition: SnackPosition.BOTTOM,
    titleText: Text("Login failed",
    style: TextStyle(
      color: Colors.white 
    ),),
    messageText: Text(
      e.toString(),
      style: TextStyle(
        color: Colors.white
      ),
    )
    );
    }
      }

// Future<UserCredential> signInWithGoogle(String userEmail, String userPass) async {
//   // Trigger the authentication flow
//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//   // Obtain the auth details from the request
//   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

//   // Create a new credential
//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth?.accessToken,
//     idToken: googleAuth?.idToken,
    
//   );

//   // Once signed in, return the UserCredential
//   return await FirebaseAuth.instance.signInWithCredential(credential);
// }
 Future<void> logout() async => await _auth.signOut();
}