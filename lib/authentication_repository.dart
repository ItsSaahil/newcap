import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
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
      String userEmail, String userPass) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: userEmail, password: userPass);
      firebaseUser.value != null
          ? Get.offAll(() => const HomePage())
          : Get.to(() => const Wellcome());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION- ${ex.message}');
      throw ex;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      print('EXCEPTION - ${ex.message}');
      throw ex;
    }
  }

  Future<void> signInWithEmailAndPassword(
      String userEmail, String userPass) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: userEmail, password: userPass);
    } on FirebaseAuthException catch (e) {
    } catch (_) {}
  }

  Future<void> logout() async => await _auth.signOut();
}
