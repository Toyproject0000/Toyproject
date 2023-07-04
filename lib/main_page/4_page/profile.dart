import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/main_page/4_page/profile_edit_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필'),
        backgroundColor: Colors.white,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, ProfileEdit.routeName);
              },
              child: Text('편집',
                  style: TextStyle(color: Colors.blue, fontSize: 16)))
        ],
      ),
      body: ListView(
        children: [
          Padding(
              padding: EdgeInsets.all(10),
              child: CircleAvatar(
                radius: 150,
                backgroundImage: AssetImage('image/personicon.png'),
              )),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'NickName',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Hello my name is minwung-kim I'm from korea. I'm 17 years old. I wanna many money",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: '독자: ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: '198',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 25,
                        ),
                      ),
                    ]),
                  ),
                  RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: '글쓴이: ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: '127',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 25,
                        ),
                      ),
                    ]),
                  )
                ]),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(
              color: Colors.grey,
              height: 1,
              thickness: 1,
              indent: 5,
              endIndent: 5,
            ),
          ),
        ],
      ),
    );
  }
}
