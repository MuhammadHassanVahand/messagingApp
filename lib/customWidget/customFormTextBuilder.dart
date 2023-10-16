import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomTextFieldBuilder extends StatefulWidget {
  final String formTextName;
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  const CustomTextFieldBuilder(
      {super.key,
      required this.formTextName,
      this.labelText,
      this.hintText,
      this.controller,
      this.autovalidateMode,
      this.validator,
      this.obscureText = false,
      this.suffixIcon});

  @override
  State<CustomTextFieldBuilder> createState() => _CustomTextFieldBuilderState();
}

class _CustomTextFieldBuilderState extends State<CustomTextFieldBuilder> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: widget.formTextName,
      controller: widget.controller,
      obscureText: widget.obscureText,
      autovalidateMode: widget.autovalidateMode,
      validator: widget.validator,
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon,
        labelText: widget.labelText,
        hintText: widget.hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.cyan, width: 2),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
