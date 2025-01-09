import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning_app/custom_widgets/keyboard_visibility_builder.dart';

class CustomTextField extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final TextAlign textAlign;
  final int maxLines;
  final String? labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final Color color;


  const CustomTextField({
    super.key, this.color=Colors.white,
    required this.controller, required this.focusNode, required this.textAlign, required this.maxLines, this.labelText, this.hintText, this.validator
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

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
      child: TextFormField( validator: widget.validator, controller: widget.controller, focusNode: widget.focusNode, maxLines: widget.maxLines,   textAlign: widget.textAlign, style: TextStyle(color: widget.color, fontSize: 18),
                               decoration: InputDecoration( labelText: widget.labelText, hintText: widget.hintText,
                                   border: const OutlineInputBorder()),),
    );
  }
}