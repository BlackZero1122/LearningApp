import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning_app/custom_widgets/keyboard_visibility_builder.dart';

class MathTextField extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;


  const MathTextField({
    super.key,
    required this.controller, required this.focusNode, this.onChanged, this.labelText, this.hintText, this.validator
  });

  @override
  State<MathTextField> createState() => _MathTextFieldState();
}

class _MathTextFieldState extends State<MathTextField> {

  @override
  void initState() {
    super.initState();
    widget.focusNode.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.dispose();
  }

  @override
  Widget build(BuildContext context){
    return KeyboardVisibilityBuilder( builder: (BuildContext context, Widget child) {
      return child;
      },
      child: TextFormField(
                                    focusNode: widget.focusNode,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    onChanged: widget.onChanged,
                                    keyboardType: TextInputType.number,
                                    controller: widget.controller,
                                    style: const TextStyle(letterSpacing: 18, fontSize: 20),
                                    textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.end,
                                    decoration: const InputDecoration( contentPadding: EdgeInsets.all(10),
                                        border: OutlineInputBorder())),
    );
  }
}