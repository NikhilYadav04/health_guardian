import 'package:intl/intl.dart';

class CurrentDate {
  static String getDate() {
    DateTime currentDate = DateTime.now();
    String date = DateFormat("MMM dd").format(currentDate).toString();
    return date;
  }

  static String getDay() {
    DateTime currentDate = DateTime.now();
    String day = DateFormat("EEE").format(currentDate);
    return day;
  }
}
