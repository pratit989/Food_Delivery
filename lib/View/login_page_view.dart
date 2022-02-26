import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';
import '../ViewModel/user_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<UserViewModel>(
        init: Get.find<UserViewModel>(),
        builder: (controller) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width * 0.2),
                        child: SizedBox(
                            height: MediaQuery.of(context).size.width * 0.4,
                            width: MediaQuery.of(context).size.height * 0.4,
                            child: Image.asset('assets/firebaseLogo.png')),
                      ),
                      SizedBox(
                        width: 2000,
                        child: FloatingActionButton.extended(
                          heroTag: 'Login With Google',
                          tooltip: 'Login With Google',
                          onPressed: () => controller.signInWithGoogleAccount(),
                          label: SizedBox(width: MediaQuery.of(context).size.width*0.6,child: const Text('Google', textAlign: TextAlign.center, style: TextStyle(fontSize: 18),)),
                          icon: const Icon(SocialIcons.google),
                          backgroundColor: Colors.blue,
                        ),
                      ),
                      FloatingActionButton.extended(
                        heroTag: 'Login via Phone',
                        tooltip: 'Login via Phone',
                        onPressed: () => controller.signInWithPhone(context),
                        label: SizedBox(width: MediaQuery.of(context).size.width*0.6,child: const Text('Phone', textAlign: TextAlign.center, style: TextStyle(fontSize: 18),)),
                        icon: const Icon(Icons.phone),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      )
    );
  }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     extendBodyBehindAppBar: true,
//     body: SafeArea(
//       child: Center(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               SizedBox(
//                   height: MediaQuery.of(context).size.width * 0.4,
//                   width: MediaQuery.of(context).size.height * 0.4,
//                   child: Image.asset('assets/firebaseLogo.png')),
//               const GoogleSignInButton(clientId: '1046208450758-alqok41jbvgajcqlgg7eilecuihg3e7g.apps.googleusercontent.com'),
//               FloatingActionButton.extended(onPressed: () => AuthAction.signIn, label: Text('Google'), icon: Icon(SocialIcons.google),),
//               FloatingActionButton.extended(onPressed: () => startPhoneVerification(context: context), label: Text('Phone'), icon: Icon(Icons.phone),),
//             ],
//           ),
//         ),
//       ),
//     ),
//     floatingActionButton: FloatingActionButton(
//       onPressed: _incrementCounter,
//       tooltip: 'Increment',
//       child: const Icon(Icons.add),
//     ),
//   );
// }
}
