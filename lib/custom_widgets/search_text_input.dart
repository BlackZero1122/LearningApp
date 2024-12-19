import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning_app/custom_widgets/keyboard_visibility_builder.dart';

class SearchTextInput extends StatelessWidget {
  final List<TextInputFormatter>? formatters;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool enabled;
  final bool readOnly;
  final Function()? onTap; final TextInputType keyboardType;
  final Function(String)? onChange;
  final Function(String)? onSubmitted;
  final Function()? onSearchButtonPressed;
  final Function()? onClearTextPressed;
  final FocusNode? focusNode;
  const SearchTextInput( 
      {super.key, this.keyboardType = TextInputType.text,
      this.onSearchButtonPressed, this.onSubmitted, this.onChange, this.onClearTextPressed,
      this.formatters, this.focusNode,
      this.hintText,
      this.controller,
      this.validator,
      this.enabled = true,
      this.onTap,
      this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      KeyboardVisibilityBuilder(
        builder: (BuildContext context, Widget child) {
      return child;
      },
        child: TextFormField( focusNode: focusNode, enabled: enabled, readOnly: readOnly, 
        // onTapOutside: (event) {
        //   FocusManager.instance.primaryFocus?.unfocus();
        // },
            autofocus: false,
            onFieldSubmitted: onSubmitted,
            controller: controller,
            onChanged: onChange,
            decoration: InputDecoration(
              labelStyle: const TextStyle(fontSize: 18),
              hintStyle: const TextStyle(fontSize: 18),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide.none),
              hintText: hintText,
              filled: true,
              fillColor: const Color(0xFFF1F2F4),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
            ),
          ),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        controller!.text.isNotEmpty
            ? IconButton(
                icon: const Icon(
                  Icons.clear,
                  size: 30,
                ),
                onPressed: onClearTextPressed
              )
            : const SizedBox(),
        IconButton(
          icon: const Icon(
            Icons.search,
            size: 30,
          ),
          onPressed: onSearchButtonPressed,
        ),
        const SizedBox(
          width: 5,
        )
      ]),
    ]);
  }
}
