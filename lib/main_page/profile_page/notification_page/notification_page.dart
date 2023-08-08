import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/main_page/profile_page/notification_page/likeandpost.dart';
import 'package:smart_dongne/main_page/profile_page/notification_page/reader_page.dart';

class AccountNotification extends StatefulWidget {
  const AccountNotification({super.key});
  static const routeName = '/userSetting/accountnotification';

  @override
  State<AccountNotification> createState() => _AccountNotificationState();
}

class _AccountNotificationState extends State<AccountNotification> {

  bool everyNotification = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text('알림'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('모든 알림 일시 중단', style: TextStyle(fontSize: 18),),
                CupertinoSwitch(
                  activeColor: Colors.blue,
                  value: everyNotification,
                  onChanged: (value){
                    setState(() {
                      everyNotification = value;
                    });
                  },
                )
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('게시물 및 댓글', style: TextStyle(fontSize: 18),),
                IconButton(onPressed: (){
                  Navigator.pushNamed(context, LikeAndPost.routeName);
                }, icon: Icon(Icons.arrow_forward_ios))
              ],
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('새로운 독자, 메세지', style: TextStyle(fontSize: 18),),
                IconButton(onPressed: (){
                  Navigator.pushNamed(context, ReaderNotification.routeName);
                }, icon: Icon(Icons.arrow_forward_ios))
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}