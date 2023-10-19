// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:messagingapp/customWidget/appText.dart';
import 'package:messagingapp/customWidget/customButton.dart';
import 'package:messagingapp/customWidget/customFormTextBuilder.dart';
import 'package:messagingapp/screens/homePaga.dart';
import 'package:messagingapp/screens/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  final String? email;
  const LoginPage({super.key, this.email});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  bool obscureText = true;
  bool isLogin = false;

  loginAuth() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      storeLoginData(emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: AppText(text: "Login successfull!"),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } catch (e) {
      isLogin = false;
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: AppText(text: "Email or Password is Invalid!"),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.email != null) {
      emailController.text = widget.email!;
    }
  }

  Future<void> storeLoginData(String email) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString("email", email);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 100,
            backgroundImage: NetworkImage(
              "https://static.vecteezy.com/system/resources/previews/014/441/089/original/chat-message-icon-design-in-blue-circle-png.png",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFieldBuilder(
                    prefixIcon: Icon(Icons.email_outlined),
                    controller: emailController,
                    formTextName: "email",
                    hintText: "example@gmail.com",
                    labelText: "Email",
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.email(),
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  CustomTextFieldBuilder(
                    prefixIcon: Icon(Icons.password_outlined),
                    controller: passwordController,
                    formTextName: "password",
                    labelText: "Password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        obscureText = !obscureText;
                        setState(() {});
                      },
                      icon: obscureText
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                    obscureText: obscureText,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                ],
              ),
            ),
          ),
          CustomAppButon(
            isLoading: isLogin,
            width: MediaQuery.of(context).size.width * 0.5,
            height: 50,
            buttonText: "Login",
            fontSize: 20,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            onPressed: () {
              if (_formKey.currentState!.saveAndValidate()) {
                setState(() {
                  isLogin = true;
                });
                loginAuth();
              }
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomAppButon(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 50,
            buttonText: "Sign Up",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignUp(),
                ),
              );
            },
          ),
        ],
      ),
    ));
  }
}
