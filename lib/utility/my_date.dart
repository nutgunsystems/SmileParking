import 'package:intl/intl.dart';

class DateUtil {
  static const DATE_FORMAT = 'yyyy-MM-dd';
  static const DATETIME_FORMAT = 'yyyy-MM-dd HH:mm';

  String formattedDate(DateTime dateTime) {
    print('dateTime ($dateTime)');
    return DateFormat(DATE_FORMAT).format(dateTime);
  }

  String formattedDateTime(DateTime dateTime) {
    print('dateTime ($dateTime)');
    return DateFormat(DATETIME_FORMAT).format(dateTime);
  }
}
