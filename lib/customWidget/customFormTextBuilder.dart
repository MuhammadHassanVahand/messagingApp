import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:messagingapp/customWidget/appText.dart';

class CustomTextFieldBuilder extends StatefulWidget {
  final String formTextName;
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  const CustomTextFieldBuilder(
      {super.key,
      required this.formTextName,
      this.labelText,
      this.hintText,
      this.controller,
      this.autovalidateMode,
      this.validator,
      this.obscureText = false,
      this.suffixIcon,
      this.prefixIcon});

  @override
  State<CustomTextFieldBuilder> createState() => _CustomTextFieldBuilderState();
}

class _CustomTextFieldBuilderState extends State<CustomTextFieldBuilder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormBuilderTextField(
          name: widget.formTextName,
          controller: widget.controller,
          obscureText: widget.obscureText,
          autovalidateMode: widget.autovalidateMode,
          validator: widget.validator,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
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
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class CustomDatePicker extends StatefulWidget {
  final Widget? suffixIcon;
  final String? labelText;
  final String? hintText;
  final AutovalidateMode? autovalidateMode;
  const CustomDatePicker({
    super.key,
    this.suffixIcon,
    this.labelText,
    this.hintText,
    this.autovalidateMode,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  String? ageValidation(DateTime? value) {
    if (value == null) {
      return "Date of birth is requaired";
    }
    final now = DateTime.now();
    // ignore: unused_local_variable
    var age = now.year - value.year;

    if (now.month < value.month ||
        now.month == value.month && now.day < value.day) {
      age--;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormBuilderDateTimePicker(
          autovalidateMode: widget.autovalidateMode,
          name: "date of birth",
          initialDate: DateTime.now(),
          inputType: InputType.date,
          format: DateFormat('yyyy-MM-dd'),
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
          validator: (value) {
            final ageError = ageValidation(value);
            return ageError;
          },
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class GenderDropDown extends StatelessWidget {
  final Widget? suffixIcon;
  const GenderDropDown({super.key, this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormBuilderDropdown(
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            labelText: "Gender",
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
          name: "gender",
          items: const [
            DropdownMenuItem(
              value: "male",
              child: AppText(text: "Male"),
            ),
            DropdownMenuItem(
              value: "female",
              child: AppText(text: "Female"),
            ),
          ],
          validator: FormBuilderValidators.required(),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
