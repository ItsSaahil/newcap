import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newcap/authentication_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final userEmail = TextEditingController();
  final userPass = TextEditingController();
  final userName = TextEditingController();
  final phoneNo = TextEditingController();

  //call this function from Desidn $ it will do the rest
  void registerUser(String userEmail, String userPass) {
    AuthenticationRepository.instance
        .createUserWithEmailAndPassword(userEmail, userPass);
  }

  void login(String userEmail, String userPass) async {
    AuthenticationRepository.instance
        .signInWithEmailAndPassword(userEmail, userPass);
  }
}
