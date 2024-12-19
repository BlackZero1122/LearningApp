import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClockWidget extends StatelessWidget {
  const ClockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        return Text(DateFormat('hh:mm:ss  EEEE  MMM dd,yyyy').format(DateTime.now()),style: const TextStyle(color: Colors.white, fontSize: 12),);
      },
    );
  }
}