import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeWidget extends StatelessWidget {
  TimeWidget({required this.contentsTime, super.key});

  String contentsTime;

  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {

    DateTime postsTime = DateTime.parse(contentsTime);
    Duration difference = now.difference(postsTime);

    int days = difference.inDays;
    int hours = difference.inHours % 24; // 나머지 출력
    int minutes = difference.inMinutes % 60;

    String timeWidget(){
      if(days == 0){
        if(hours == 0){
          String minuteString = minutes.toString();
          return '${minuteString}분';
        }else{
          String hourString = hours.toString();
          return '${hourString}시간';
        }
      }else {
        String dayString = days.toString();
        return '${dayString}일';
      }
    }

    return Text('${timeWidget()} 전', style: TextStyle(color: Colors.grey[800]),);
  }
}
