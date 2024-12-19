import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color? backgroundcolor;
  final String text;
  final Color? fontcolor;
  final Function()? onTap;
  final double? height;
  const CustomButton(
      {super.key,
      this.height,
      this.backgroundcolor,
      required this.text,
      this.fontcolor,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundcolor,
            foregroundColor: fontcolor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        onPressed: onTap,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(color: fontcolor),
        ),
      ),
    );
  }
}
