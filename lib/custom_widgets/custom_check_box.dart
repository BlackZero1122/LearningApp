import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
 final bool? value;
final Function(bool?)? onchange;
final Function()? ontap;
final String? text;
final Color? color;

  const CustomCheckBox({super.key, 
    required this.value,
    required this.onchange,
    required this.ontap,
    required this.text,
    required this.color,
    
    });

  @override
  Widget build(BuildContext context) {
    return Row(
                                    children: [
                                      Checkbox(
                                        value: value,
                                        onChanged: onchange,
                                      ),
                                      GestureDetector(
                                        onTap: ontap,
                                        child: Text(text!,
                                          style: TextStyle(
                                            color: color 
                                          ),
                                        ),
                                      ),
         ],
      );
  }
}