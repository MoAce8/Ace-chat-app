import 'package:intl/intl.dart';

class DateTimeFormatting{
  static String dateFormatter(String time){
    var date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return DateFormat('d/m/yy').format(date).toString();
  }

  static String timeFormatter(String time){
    var date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return DateFormat.Hm().format(date).toString();
  }

  static String dateAndTime({required String time, required bool lastSeen,}){
    String shownDate = '';
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    final today = DateTime.now();
    final yesterday = DateTime.now().add(const Duration(days: -1));

    final d = DateTime(date.year, date.month, date.day);
    final t = DateTime(today.year, today.month, today.day);
    final y = DateTime(yesterday.year, yesterday.month, yesterday.day);

    if(d==t){
      shownDate = 'today';
    }else if(d==y){
      shownDate = 'yesterday';
    }else{
      shownDate = DateFormat('d/M/yy').format(date).toString();
    }
    if(lastSeen && (shownDate == 'today' || shownDate == 'yesterday')){
      String timer = timeFormatter(time);
      return '$shownDate at $timer';
    }else{
      return shownDate;
    }
  }
}