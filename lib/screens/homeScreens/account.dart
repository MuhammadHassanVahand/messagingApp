import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:messagingapp/customWidget/appText.dart';
import 'package:messagingapp/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  final String email;
  final String fullName;
  final String phoneNumber;
  final String gender;
  final Timestamp dateOfBirth;
  AccountScreen(
      {Key? key,
      required this.email,
      required this.fullName,
      required this.phoneNumber,
      required this.gender,
      required this.dateOfBirth});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Future<void> signOut() async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage(
                        "assets/images/anonymous-user-circle-icon-vector-18958255.jpg"),
                    radius: 100,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppText(text: widget.fullName, fontSize: 20),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    title: const AppText(text: "Email: "),
                    trailing: AppText(text: widget.email),
                  ),
                  ListTile(
                    title: const AppText(text: "Phone Number: "),
                    trailing: AppText(text: widget.phoneNumber),
                  ),
                  ListTile(
                    title: const AppText(text: "Date Of Birth: "),
                    trailing: AppText(
                      text: DateFormat("dd-MM-yyyy").format(
                        widget.dateOfBirth.toDate(),
                      ),
                    ),
                  ),
                  ListTile(
                    title: const AppText(text: "Gender: "),
                    trailing: AppText(text: widget.gender),
                  ),
                ],
              ),
              ListTile(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  signOut();
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                title: const AppText(text: "Sign Out"),
                trailing: Icon(Icons.logout),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
