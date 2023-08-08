import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReaderNotification extends StatefulWidget {
  const ReaderNotification({super.key});

  static const routeName = '/readerNotification';
  @override
  State<ReaderNotification> createState() => _ReaderNotificationState();
}

class _ReaderNotificationState extends State<ReaderNotification> {

  List SettingRange = ['설정' , '해제'];
  String readerCurrentValue = '설정';
  String messageCurrentValue = '설정';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text('새로운 독자, 메세지'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                Text(
                  '새로운 독자 알림',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                RadioListTile(
                  activeColor: Colors.blue,
                  title: Text(SettingRange[0]),
                  value: SettingRange[0],
                  groupValue: readerCurrentValue,
                  onChanged: (value) {
                    setState(() {
                      readerCurrentValue = value;
                    });
                  },
                ),
                RadioListTile(
                  activeColor: Colors.blue,
                  title: Text(SettingRange[1]),
                  value: SettingRange[1],
                  groupValue: readerCurrentValue,
                  onChanged: (value) {
                    setState(() {
                      readerCurrentValue = value;
                    });
                  },
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                  height: 30,
                ),
                Text(
                  '메세지 알림',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                RadioListTile(
                  activeColor: Colors.blue,
                  title: Text(SettingRange[0]),
                  value: SettingRange[0],
                  groupValue: messageCurrentValue,
                  onChanged: (value) {
                    setState(() {
                      messageCurrentValue = value;
                    });
                  },
                ),
                RadioListTile(
                  activeColor: Colors.blue,
                  title: Text(SettingRange[1]),
                  value: SettingRange[1],
                  groupValue: messageCurrentValue,
                  onChanged: (value) {
                    setState(() {
                      messageCurrentValue = value;
                    });
                  },
                ),
          ],
        ),
      ),
    );
  }
}