import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:messagingapp/customWidget/customButton.dart';
import 'package:messagingapp/customWidget/customFormTextBuilder.dart';
import 'package:messagingapp/screens/homePaga.dart';
import 'package:messagingapp/screens/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFieldBuilder(
                    formTextName: "email",
                    hintText: "example@gmail.com",
                    labelText: "Email",
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.email(),
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFieldBuilder(
                    formTextName: "password",
                    labelText: "Password",
                    obscureText: true,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                ],
              ),
            ),
          ),
          CustomAppButon(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 50,
            buttonText: "Login",
            fontSize: 20,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          ),
          SizedBox(
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignUp(),
                ),
              );
            },
          ),
        ],
      ),
    ));
  }
}
