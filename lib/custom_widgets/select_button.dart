import 'package:flutter/material.dart';
import 'package:learning_app/helpers/icons_helper.dart';

class SelectButton extends StatelessWidget {
  final String text;
  final String icon;
  final Color selectedForegroundColor;
  final Color selectedBackgroundColor;
  final Color unselectedForegroundColor;
  final Color unselectedBackgroundColor;
  final Function()? onPressed;
  final bool disabled;
  final bool selected;
  const SelectButton(
      {super.key, this.disabled=false,
      required this.text, required this.selected,
      required this.icon,
      this.unselectedForegroundColor = Colors.grey,
      this.unselectedBackgroundColor=Colors.white,
      this.selectedForegroundColor = Colors.white,
      this.selectedBackgroundColor=Colors.green,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          padding: WidgetStateProperty.all(const EdgeInsets.all(10)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: disabled ? const BorderSide(color: Color(0xFFF1F2F4), width: 2) : BorderSide(color: selected ? selectedBackgroundColor : unselectedForegroundColor, width: 1))),
          elevation: WidgetStateProperty.all(0),
          foregroundColor: disabled ? WidgetStateProperty.all(Colors.white) : WidgetStateProperty.all(selected ? selectedForegroundColor : unselectedForegroundColor),
          backgroundColor: disabled ? const WidgetStatePropertyAll(Color(0xFFF1F2F4)) :WidgetStatePropertyAll(selected ? selectedBackgroundColor : unselectedBackgroundColor)),
      onPressed: disabled ? null : onPressed,
      child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(IconsHelper.map[icon], size: 35,),
                const SizedBox(
                  width: 3,
                ),
                Text(text, style: const TextStyle(fontSize: 18),),
              ],
            ),
    );
  }
}
