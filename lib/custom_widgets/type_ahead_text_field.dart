import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class TypeAheadTextField extends StatelessWidget {
  const TypeAheadTextField({
    super.key,
    required this.controller, required this.builder, this.focusNode, required this.onSelected, required this.suggestionsCallback, required this.itemBuilder, this.emptyBuilder,
  });

  final FocusNode? focusNode;
  final TextEditingController controller;
  final FutureOr<List<dynamic>?> Function(String) suggestionsCallback;
  final Widget Function(BuildContext, dynamic) itemBuilder;
  final Widget Function(BuildContext)? emptyBuilder;
  final void Function(dynamic)? onSelected;
  final Widget Function(BuildContext, TextEditingController, FocusNode)? builder;

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(hideWithKeyboard: false, retainOnLoading: false, focusNode: focusNode,
      controller: controller,
      animationDuration:
          const Duration(
              microseconds: 100),
      debounceDuration:
          const Duration(seconds: 1),
      suggestionsCallback:suggestionsCallback,
      builder:builder,
      itemBuilder: itemBuilder,
      emptyBuilder: emptyBuilder,
      onSelected: onSelected,
    );
  }
}