import 'package:intl/intl.dart';

class MessageTime {

  static DateTime returnDateAndTimeFormat(String time){
    var dt = DateTime.parse(time.toString());
    var originalDate = DateFormat('MM/dd/yyyy').format(dt);
    return DateTime(dt.year, dt.month , dt.day);

  }


  static String groupMessageDateAndTime(String time){

    var dt = DateTime.parse(time.toString());
    var originalDate = DateFormat('MM/dd/yyyy').format(dt);

    final todayDate = DateTime.now();

    final today = DateTime(todayDate.year, todayDate.month, todayDate.day);
    final yesterday = DateTime(todayDate.year, todayDate.month, todayDate.day - 1);
    String difference = '';
    final aDate = DateTime(dt.year, dt.month, dt.day);


    if(aDate == today) {
      difference = "Today" ;
    } else if(aDate == yesterday) {
      difference = "Yesterday" ;
    }
    else {
      difference = DateFormat.yMMMd().format(dt).toString() ;
    }

    return difference ;

  }


  static DateTime returnHourAndMinuteFormat(Date) {
    DateTime dateTime = DateTime.parse(Date);
    final aDate = DateTime(dateTime.hour, dateTime.minute);
    return aDate;
  }

  static String groupMessageHoureandMinute(String time) {
    
    var dt = DateTime.parse(time);
    String difference = '';
    difference = DateFormat('HH:mm').format(dt);
    return difference;
  
  }

}