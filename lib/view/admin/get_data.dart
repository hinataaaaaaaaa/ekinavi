import 'package:intl/intl.dart';

class Data {
  DateTime now = DateTime.now();

  List<dynamic> getFormattedDateTime() {
    // 日付のフォーマットを指定して表示
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    // 時間のフォーマットを指定して表示
    String formattedTime = DateFormat('HH:mm:ss').format(now);

    // 日付と時間を個別に取得
    int year = now.year;
    int month = now.month;
    int day = now.day;
    int hour = now.hour;
    int minute = now.minute;
    int second = now.second;
    int millisecond = now.millisecond;
    int microsecond = now.microsecond;

    return [
      formattedDate,
      formattedTime,
      year,
      month,
      day,
      hour,
      minute,
      second,
      millisecond,
      microsecond,
    ];
  }
}
