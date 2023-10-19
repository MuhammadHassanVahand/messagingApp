import 'package:flutter/material.dart';
import 'package:messagingapp/customWidget/appText.dart';

class CustomAppButon extends StatefulWidget {
  final String buttonText;
  final Color? textColor;
  final double? fontSize;
  final double? width;
  final double? height;
  final Function()? onPressed;
  final Color? backgroundColor;
  final FontWeight? fontWeight;
  final bool isLoading;
  const CustomAppButon({
    super.key,
    this.textColor,
    this.fontSize,
    this.width,
    this.height,
    required this.buttonText,
    this.onPressed,
    this.backgroundColor,
    this.fontWeight,
    this.isLoading = false,
  });

  @override
  State<CustomAppButon> createState() => _CustomAppButonState();
}

class _CustomAppButonState extends State<CustomAppButon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: widget.isLoading ? null : widget.onPressed,
        child: widget.isLoading
            ? CircularProgressIndicator()
            : AppText(
                text: widget.buttonText,
                color: widget.textColor,
                fontSize: widget.fontSize,
                fontWeight: widget.fontWeight,
              ),
      ),
    );
  }
}
