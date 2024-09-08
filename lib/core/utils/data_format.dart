import 'package:intl/intl.dart';

class DataFormat {
  // Method to format DateTime to full date and time format
  static String formatFullDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(dateTime);
  }

  // Method to format DateTime to short date format (e.g., 'dd/MM/yyyy')
  static String formatShortDate(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dateTime);
  }

  // Method to format DateTime to long date format (e.g., 'MMMM dd, yyyy')
  static String formatLongDate(DateTime dateTime) {
    final DateFormat formatter = DateFormat('MMMM dd, yyyy');
    return formatter.format(dateTime);
  }

  // Method to format DateTime to time format (e.g., 'HH:mm')
  static String formatTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('HH:mm');
    return formatter.format(dateTime);
  }

  // Method to format DateTime to short time format with seconds (e.g., 'HH:mm:ss')
  static String formatTimeWithSeconds(DateTime dateTime) {
    final DateFormat formatter = DateFormat('HH:mm:ss');
    return formatter.format(dateTime);
  }
}
