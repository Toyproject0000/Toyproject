import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/component/myButton.dart';
import 'package:smart_dongne/component/my_Text_Form_Field.dart';
import 'package:smart_dongne/server/Server.dart';
import 'package:smart_dongne/server/userId.dart';

class UserReportAndCutoff {

  final BuildContext context;
  UserReportAndCutoff(this.context);

  TextEditingController _controller = TextEditingController();

  late String reportORcutoffUser;
  late String reportORcutoffUserRoot;

  void onPressRoportButton() async {
    if(_controller.text.isNotEmpty){
      if (reportORcutoffUser == globalUserId) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          content: Text(
            '자기 게시물은 신고 수 없습니다.',
            style: TextStyle(fontSize: 14),
          ),
          backgroundColor: Colors.blue[400],
        ));
      } else {
        final data = {
          'token': jwtToken,
          'reportingUserId': globalUserId,
          'reportedUserId': reportORcutoffUser,
          'reportingUserRoot' : LoginRoot,
          'reportedUserRoot' : reportORcutoffUserRoot,
          'reason' : _controller.text
        };
        final response = await ServerResponseOKTemplate('/report/user', data);
        if (response != null) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${reportORcutoffUser} 를 신고하였습니다.')));
        }
      }
    }
  }

  void makeReportReason(String user, String root) {
    //variable allocation
    reportORcutoffUser = user;
    reportORcutoffUserRoot = root;

    // make reason to UserReport
    showDialog(
      context: context,
      builder: (context){
        return Dialog(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width - 10,
            height: MediaQuery.of(context).size.height /3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('신고 사유', style: TextStyle(color: Colors.black, fontSize: 20), ),
                SizedBox(height: 20,),
                MyTextFormField(controller: _controller, hintText: '이유를 적으시오', obscureText: false),
                SizedBox(height: 10,),
                MyButton(text: '신고하기', onPresse: onPressRoportButton),
              ],
            ),
          ),
        );
      });
  }

  void userCutOff(String user, String root) {
    showDialog(context: context,
    builder: (context){
      return AlertDialog(
        content: Text('해당 유저를 차단하시겠습니까?' , style: TextStyle(color: Colors.black),),
        actions: [
          TextButton(onPressed: () async {
            final data = {
              'token' : jwtToken,
              'reportingUserId' : globalUserId,
              'reportedUserId' : user,
              'reportingUserRoot' : LoginRoot,
              'reportedUserRoot' : root
            };
            final response = await ServerResponseOKTemplate('/block/user', data);
            if(response != null){
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${user} 님을 차단하였습니다.')));
            }

          }, child: Text('차단하기', style: TextStyle(color: Colors.blue),))
        ],
      );
    });
    
  }
}