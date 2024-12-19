import 'package:flutter/material.dart';

class MeasureSize extends StatefulWidget {
  final Widget child;
  final ValueChanged<Size> onSizeChange;

  const MeasureSize({
    Key? key,
    required this.child,
    required this.onSizeChange,
  }) : super(key: key);

  @override
  _MeasureSizeState createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<MeasureSize> {
  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(MeasureSize oldWidget) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
    super.didUpdateWidget(oldWidget);
  }

  void _notifySize() {
    try {
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
    widget.onSizeChange(renderBox.size);
    } catch (e) {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}