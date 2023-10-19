import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messagingapp/firebase_options.dart';
import 'package:messagingapp/screens/homePaga.dart';
import 'package:messagingapp/screens/homeScreens/account.dart';
import 'package:messagingapp/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final pref = await SharedPreferences.getInstance();
  final savedEmail = pref.getString("email");
  final isLoggedIn = FirebaseAuth.instance.currentUser != null;
  runApp(MyApp(
    email: savedEmail,
    prefs: pref,
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences? prefs;
  final String? email;
  final bool isLoggedIn;
  const MyApp({super.key, this.prefs, this.email, required this.isLoggedIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      home: isLoggedIn ? const HomePage() : LoginPage(email: email),
    );
  }
}
