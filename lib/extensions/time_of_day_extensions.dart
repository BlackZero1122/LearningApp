import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  bool isBefore(TimeOfDay other) {
    return (60 * hour + minute) < (60 * other.hour + other.minute);
  }

  bool theSame(TimeOfDay other) {
    return (60 * hour + minute) == (60 * other.hour + other.minute);
  }

  bool isBeforeNow() {
    return isBefore(TimeOfDay.fromDateTime(DateTime.now()));
  }

  bool theSameNow() {
    return theSame(TimeOfDay.fromDateTime(DateTime.now()));
  }

  bool isBeforeDate(DateTime date) {
    return isBefore(TimeOfDay.fromDateTime(date));
  }

  bool theSameDate(DateTime date) {
    return theSame(TimeOfDay.fromDateTime(date));
  }
}