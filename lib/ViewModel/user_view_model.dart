import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Model/user_model.dart';
import '../Service/firestore_user_service.dart';
import '../Service/local_storage_user_service.dart';
import '../View/control_view.dart';

class UserViewModel extends GetxController {
  final Rxn<User>? _user = Rxn<User>();

  User? get user => _user?.value;
  String? get name => _user?.value?.displayName;
  String? get email => _user?.value?.email;
  String? get uid => _user?.value?.uid;

  final _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    _user!.bindStream(_auth.authStateChanges());
  }

  void signInWithPhone(BuildContext context) async {
    await startPhoneVerification(context: context, auth: _auth);
    Get.offAll(const ControlView());
  }

  void signInWithGoogleAccount() async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
      final GoogleSignInAccount? _googleUser = await _googleSignIn.signIn();

      GoogleSignInAuthentication _googleSignInAuthentication =
      await _googleUser!.authentication;
      final _googleAuthCredential = GoogleAuthProvider.credential(
        idToken: _googleSignInAuthentication.idToken,
        accessToken: _googleSignInAuthentication.accessToken,
      );

      await _auth.signInWithCredential(_googleAuthCredential);
      Get.offAll(const ControlView());
    } catch (error) {
      String errorMessage =
      error.toString().substring(error.toString().indexOf(' ') + 1);
      Get.snackbar(
        'Failed to login..',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
      LocalStorageUser.clearUserData();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }
}