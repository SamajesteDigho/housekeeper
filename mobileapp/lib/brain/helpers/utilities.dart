import 'package:flutter/material.dart';

class MyUtilities {
  static List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  static List<String> daysFull = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  static List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  static List<String> monthsFull = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'Jun',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  static String parseDate(DateTime? date, {bool full = false}) {
    if (date == null) {
      return '';
    }
    if (full) {
      return '${daysFull[date.weekday - 1]} ${monthsFull[date.month]} ${date.day}, ${date.year}';
    } else {
      return '${days[date.weekday - 1]} ${months[date.month - 1]} ${date.day}, ${date.year}';
    }
  }

  static String parseTime(TimeOfDay? time, {bool full = false}) {
    if (time == null) {
      return '';
    }
    return '${time.hour} : ${time.minute}';
  }

  static int getAge(DateTime? date) {
    if (date == null) {
      return 0;
    }
    int age = DateTime.now().compareTo(date);
    return age;
  }
}
