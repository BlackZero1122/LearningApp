import 'package:intl/intl.dart';

extension StringExtension on String {
  static String get currentDateTime => DateTime.now().toString();
  static String? truncate(String? text, int length) {
    if (text == null) {
      return null;
    }
    if (length >= text.length) {
      return text;
    }
    return text.replaceRange(length, text.length, "...");
  }
  static String? formatPhone(String? text) => (text!=null && text.isNotEmpty && text.length==10)? text.replaceAllMapped(
    RegExp(r'(\d{3})(\d{3})(\d{4})'),
    (final Match m) => '(${m[1]}) ${m[2]} ${m[3]}',
  ):"N/A";
  static String? unformatPhone(String? text) => (text!=null && text.isNotEmpty && text.length==14)? text.replaceAll(RegExp(r'[^0-9]'),''):"";
  String trimCharLeft(String pattern) {
    if (isEmpty || pattern.isEmpty || pattern.length > length) return this;
    var tmp = this;
    while (tmp.startsWith(pattern)) {
      tmp = substring(pattern.length);
    }
    return tmp;
  }

  String trimCharRight(String pattern) {
    if (isEmpty || pattern.isEmpty || pattern.length > length) return this;
    var tmp = this;
    while (tmp.endsWith(pattern)) {
      tmp = substring(0, length - pattern.length);
    }
    return tmp;
  }

  String trimChar(String pattern) {
    return trimCharLeft(pattern).trimCharRight(pattern);
  }

  static bool isNumeric(String? s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
  }

  static String getInitials(String text) => text.isNotEmpty
    ? (text.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()).toUpperCase()
    : '';

    
 
  String formatDateTime() {
    try {
      // Parse the string into a DateTime object
      DateTime dateTime = DateTime.parse(this);

      // Define the desired format without milliseconds
      DateFormat formatter = DateFormat('MM/dd/yyyy HH:mm:ss');

      // Format the DateTime object
      return formatter.format(dateTime);
    } catch (e) {
      // Handle parse errors
      return 'Invalid date-time format';
    }
  
  }

  String formatDate() {
    try {
      final DateTime date = DateTime.parse(this);
    final DateFormat formatter = DateFormat('MM/dd/yyyy');
    return formatter.format(date);
    } catch (e) {
      // Handle parse errors
      return 'Invalid date-time format';
    }
  }

  String formatTime(String format) {
   try {
      final DateTime date = DateTime.parse(this);
    final DateFormat formatter = DateFormat(format);
    return formatter.format(date);
   } catch (e) {
     // Handle parse errors
      return 'Invalid date-time format';
   }
  }
}