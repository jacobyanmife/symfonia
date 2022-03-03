import 'package:intl/intl.dart';

class Utils {
  static String formatDate(String dateString) {
    final date = DateTime.tryParse(dateString);

    return DateFormat('HH:mm, MMM d, y').format(date!);
  }
}
