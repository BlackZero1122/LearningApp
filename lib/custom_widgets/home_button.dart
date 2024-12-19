import 'package:flutter/material.dart';
import 'package:learning_app/helpers/icons_helper.dart';

class HomeButton extends StatelessWidget {
  final String text;
  final bool isPrimary;
  final String icon;
  final Color foregroundColor;
  final Color backgroundColor;
  final Function()? onPressed;
  final bool disabled;
  const HomeButton(
      {super.key, this.disabled=false,
      this.isPrimary = true,
      required this.text,
      required this.icon,
      required this.foregroundColor,
      required this.backgroundColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          padding: WidgetStateProperty.all(const EdgeInsets.all(10)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: disabled ? const BorderSide(color: Color(0xFFF1F2F4), width: 2) : BorderSide(color: backgroundColor, width: 2))),
          elevation: WidgetStateProperty.all(0),
          foregroundColor: disabled ? WidgetStateProperty.all(Colors.white) : WidgetStateProperty.all(foregroundColor),
          backgroundColor: disabled ? const WidgetStatePropertyAll(Color(0xFFF1F2F4)) : isPrimary
              ? WidgetStatePropertyAll(backgroundColor)
              : const WidgetStatePropertyAll(Colors.transparent)),
      onPressed: disabled ? null : onPressed,
      child: isPrimary
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(IconsHelper.map[icon], size: 35,),
                const SizedBox(
                  width: 3,
                ),
                Text(text, style: const TextStyle(fontSize: 18),),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(IconsHelper.map[icon], size: 35,),
                const SizedBox(
                  width: 3,
                ),
                Text(text,style: const TextStyle(fontSize: 18),),
              ],
            ),
    );
  }
}
