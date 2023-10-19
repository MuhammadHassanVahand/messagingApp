import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messagingapp/screens/homeScreens/account.dart';
import 'package:messagingapp/screens/homeScreens/message.dart';
import 'package:messagingapp/screens/homeScreens/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  User? user;
  late String email = "";
  late String fullName = "";
  late String phoneNumber = "";
  late String gender = "";
  late Timestamp dateOfBirth = Timestamp.now();

  Future<void> fatchUserData() async {
    final User? currentUser = auth.currentUser;
    if (currentUser != null) {
      final userData = await users.doc(currentUser.uid).get();
      setState(() {
        user = currentUser;
        fullName = userData["full name"] ?? "";
        email = userData["email"] ?? "";
        phoneNumber = userData["phone number"] ?? "";
        gender = userData["gender"] ?? "";
        dateOfBirth = userData["date of birth"] ?? "";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fatchUserData();
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List screens = [
      MessageScreen(),
      SearchScreen(),
      AccountScreen(
        email: email,
        fullName: fullName,
        phoneNumber: phoneNumber,
        gender: gender,
        dateOfBirth: dateOfBirth,
      ),
    ];
    return SafeArea(
        child: Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.message_outlined),
              label: "Messages",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: "Account",
            ),
          ]),
    ));
  }
}
