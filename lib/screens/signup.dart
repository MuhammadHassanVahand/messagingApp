// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:messagingapp/customWidget/appText.dart';
import 'package:messagingapp/customWidget/customButton.dart';
import 'package:messagingapp/customWidget/customFormTextBuilder.dart';
import 'package:messagingapp/screens/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  bool obscureText = true;
  bool isSignup = false;

  signUpAuth(
    emailAddress,
    password,
    fullName,
    dateOfBirth,
    phoneNumber,
    gender,
  ) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user?.uid)
          .set({
        "full name": fullName,
        "email": emailAddress,
        "date of birth": dateOfBirth,
        "phone number": phoneNumber,
        "gender": gender,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: AppText(text: "Sign up successfull!"),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: AppText(text: "The password provided is too weak."),
          ),
        );
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                AppText(text: "The account already exists for that email."),
          ),
        );
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      CustomTextFieldBuilder(
                        prefixIcon: Icon(Icons.person_2),
                        formTextName: "full name",
                        labelText: "Full Name",
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      CustomTextFieldBuilder(
                        prefixIcon: Icon(Icons.email),
                        controller: emailController,
                        formTextName: "email",
                        labelText: "Email address",
                        hintText: "example@gmail.com",
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.email(),
                        ]),
                      ),
                      CustomTextFieldBuilder(
                        prefixIcon: Icon(Icons.phone),
                        formTextName: "phone number",
                        labelText: "Phone Number",
                        hintText: "03000000000",
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.numeric(),
                          FormBuilderValidators.minLength(11),
                        ]),
                      ),
                      CustomTextFieldBuilder(
                        prefixIcon: Icon(Icons.password_sharp),
                        controller: passwordController,
                        suffixIcon: IconButton(
                          onPressed: () {
                            obscureText = !obscureText;
                            setState(() {});
                          },
                          icon: obscureText
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        ),
                        formTextName: "password",
                        labelText: "Passwrod",
                        obscureText: obscureText,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.minLength(8),
                        ]),
                      ),
                      CustomTextFieldBuilder(
                        prefixIcon: Icon(Icons.password_sharp),
                        suffixIcon: IconButton(
                          onPressed: () {
                            obscureText = !obscureText;
                            setState(() {});
                          },
                          icon: obscureText
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        ),
                        formTextName: "confirm passwword",
                        labelText: "Confirm Passwrod",
                        obscureText: obscureText,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            _formKey.currentState?.fields["password"]?.value !=
                                    value
                                ? "No Coinciden"
                                : null,
                      ),
                      const CustomDatePicker(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        labelText: "Date Of Birth",
                        suffixIcon: Icon(
                          Icons.calendar_month_outlined,
                        ),
                      ),
                      GenderDropDown(),
                      CustomAppButon(
                        isLoading: isSignup,
                        onPressed: () {
                          if (_formKey.currentState!.saveAndValidate()) {
                            setState(() {
                              isSignup = true;
                            });
                            final formData = _formKey.currentState!.value;
                            final fullName = formData["full name"];
                            final emailAddress = formData["email"];
                            final phoneNumber = formData["phone number"];
                            final password = formData["password"];
                            final dateOfBirth = formData["date of birth"];
                            final gender = formData["gender"];
                            signUpAuth(
                              emailAddress,
                              password,
                              fullName,
                              dateOfBirth,
                              phoneNumber,
                              gender,
                            ).then(() {
                              setState(() {
                                isSignup = false;
                              });
                            });
                          }
                        },
                        buttonText: "Sign Up",
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 60,
                        fontSize: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(text: "Back to login screen:"),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ));
                              },
                              child: AppText(text: "Login"))
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
