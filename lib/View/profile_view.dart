import 'package:flutter/material.dart';
import 'package:food_app/ViewModel/user_view_model.dart';
import 'package:get/get.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserViewModel>(
        init: Get.find<UserViewModel>(),
        builder: (controller) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Drawer(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.green,
                          Colors.green[700]!,
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.04),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: CircleAvatar(
                              radius: MediaQuery.of(context).size.width * 0.08,
                              backgroundImage: const AssetImage('assets/firebaseLogo.png'),
                            ),
                          ),
                          Text(
                            controller.name ?? 'Phone Auth',
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(
                            'UID: ${controller.uid}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.signOut();
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30.0, top: 20),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.exit_to_app,
                            size: 35,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08),
                            child: const Text(
                              'Log Out',
                              style: TextStyle(fontSize: 20, color: Colors.grey),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
