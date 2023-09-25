import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_dongne/component/myButton.dart';
import 'package:smart_dongne/login_page/social_login_setting.dart';
import 'package:smart_dongne/login_page/TermsofService/termsofservice.dart';
import 'package:smart_dongne/login_page/join_membership_page.dart';
import 'package:smart_dongne/provider/JoinArgeement.dart';
import 'package:smart_dongne/server/userId.dart';

class UserConsent extends StatefulWidget {
  const UserConsent({super.key});
  static const routeName = '/userConsent';

  @override
  State<UserConsent> createState() => _UserConsentState();
}

class _UserConsentState extends State<UserConsent> {
  
  late JoinArgeement _joinArgeement;

  void onPress() {
    if(Provider.of<JoinArgeement>(context, listen: false).AllargeeMent == true){
      if(LoginRoot == 'local'){
        Navigator.pushNamed(context, Joinmembership.routeName);
      }else {
        Navigator.pushNamed(context, SocialLoginSetting.routeName);
      }
    }
  }
  

  @override
  Widget build(BuildContext context) {
    _joinArgeement = Provider.of<JoinArgeement>(context, listen: false);
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Writer',
          style: TextStyle(color: Colors.blue, fontSize: 25),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        child: Column(
          children: [
            ListTile(
              leading: Consumer(
                builder: (context, child, provider){
                  return IconButton(
                    onPressed: () {
                      _joinArgeement.onPresseAllargeeMent();
                    },
                    icon: Icon(
                      Icons.check_circle_outline,
                      size: 25,
                      color: Provider.of<JoinArgeement>(context).AllargeeMent == false ? Colors.grey : Colors.blue,
                    ),
                  );
                },
              ),
              title: Text(
                '전체 동의하기',
                style: TextStyle(fontSize: 20),
              ),
            ),

            ListTile(
              leading: Consumer(
                builder: (context, provider, child){
                  return IconButton(
                    onPressed: () {
                      _joinArgeement.onPresstermsargeement();
                    },
                    icon: Icon(
                      Icons.check_circle_outline,
                      size: 25,
                      color:
                          Provider.of<JoinArgeement>(context).termsargeement == false ? Colors.grey : Colors.blue,
                    ),
                  );
                },
              ),
              trailing: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, TermsofService.routeName);
                },
                icon: Icon(Icons.arrow_forward_ios),
                color: Colors.grey,
              ),
              title: Text(
                '글쓴이 이용약관',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              leading: Consumer(
                builder: (context, child, provider){
                  return IconButton(
                    onPressed: () {
                      _joinArgeement.onPresspersonalinformaitionArgeement();
                    },
                    icon: Icon(
                      Icons.check_circle_outline,
                      size: 25,
                      color: Provider.of<JoinArgeement>(context).personalinformaitionArgeement == false
                          ? Colors.grey
                          : Colors.blue,
                    ),
                  );
                },
              ),
              trailing: IconButton(
                onPressed: () async {
                  await Navigator.pushNamed(
                      context, TermsofService.routeName);
                },
                icon: Icon(Icons.arrow_forward_ios),
                color: Colors.grey,
              ),
              title: Text(
                '개인정보 수집 및 이용',
                style: TextStyle(fontSize: 20),
              ),
            ),
            
            SizedBox(
              height: 20,
            ),
            MyButton(text: '다음', onPresse: onPress)
          ],
        ),
      ),
    );
  }
}

