import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_dongne/component/myButton.dart';
import 'package:smart_dongne/component/my_Text_Form_Field.dart';
import 'package:smart_dongne/provider/setPageData.dart';
import 'package:smart_dongne/server/Server.dart';
import 'package:smart_dongne/server/userId.dart';

class UserWithDrawal extends StatelessWidget {
  UserWithDrawal({super.key});

  // material allocation 
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SetPageProvider _setPageProvider = Provider.of<SetPageProvider>(context, listen: false);

    void onTap() {
      if(emailController.text == globalUserId){
        final data = {
          'token' : jwtToken,
          'id' : emailController.text,
          'root' : LoginRoot 
        };

        showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                content: Text('${emailController.text} 해당 계정을 탈퇴하시겠습니까?'),
                actions: [
                  TextButton(
                    onPressed: () async {
                      final response = await ServerResponseOKTemplate('/remove', data);
                        if(response != null){
                            LoginRoot = '';
                          globalNickName = '';
                          globalUserId = '';
                          _setPageProvider.ChangeScreen(0);
                          Navigator.popUntil(context, ModalRoute.withName('/'));
                      }
                    },
                    child: Text('탈퇴하기', style: TextStyle(color: Colors.blue),)
                  )
                ],
              );
            });
        }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('계정 탈퇴', style: TextStyle(color: Colors.black, fontSize: 25),),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Column(
          children: [
            MyTextFormField(controller: emailController, hintText: '이메일을 입력하시오', obscureText: false),
            SizedBox(height: 30,),
            MyButton(text: '탈퇴하기', onPresse: onTap)
          ],
        ),
      ),
    );
  }
}