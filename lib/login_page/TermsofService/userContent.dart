import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/login_page/TermsofService/termsofservice.dart';
import 'package:smart_dongne/login_page/join_membership_page.dart';

class UserConsent extends StatefulWidget {
  const UserConsent({super.key});
  static const routeName = '/userConsent';

  @override
  State<UserConsent> createState() => _UserConsentState();
}

class _UserConsentState extends State<UserConsent> {
  bool allconsend = false;
  bool termsofservice = false;
  bool personalInfomation = false;

  bool isLoading = false;
  

  @override
  Widget build(BuildContext context) {
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
      body:  Container(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        child: Column(
          children: [
            Row(children: [
              IconButton(
                onPressed: () {
                  if(allconsend == false){
                      setState(() {
                        allconsend = true;
                        termsofservice = true;
                        personalInfomation = true;
                      });
                    }else{
                      setState(() {
                        allconsend = false;
                        termsofservice = false;
                        personalInfomation = false;
                      });
                    }
                },
                icon: Icon(
                  Icons.check_circle_outline,
                  size: 25,
                  color: allconsend == false ? Colors.grey : Colors.blue,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '전체 동의하기',
                style: TextStyle(fontSize: 20),
              )
            ]),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          termsofservice = !termsofservice;
                          if(termsofservice == true && personalInfomation == true){
                            allconsend = true;
                          }else{
                            allconsend = false;
                          }
                        });
                      },
                      icon: Icon(
                        Icons.check_circle_outline,
                        size: 25,
                        color: termsofservice == false ? Colors.grey : Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '글쓴이 이용약관',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, TermsofService.routeName);
                    },
                    icon: Icon(Icons.arrow_forward_ios), color: Colors.grey,),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          personalInfomation = !personalInfomation;
                          if(termsofservice == true && personalInfomation == true){
                            allconsend = true;
                          }else{
                            allconsend = false;
                          }
                        });
                      },
                      icon: Icon(
                        Icons.check_circle_outline,
                        size: 25,
                        color: personalInfomation == false ? Colors.grey : Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '개인정보 수집 및 이용',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ), 
                IconButton(
                    onPressed: () async {
                      await Navigator.pushNamed(context, TermsofService.routeName);
                    },
                    icon: Icon(Icons.arrow_forward_ios), color: Colors.grey,),
              ],
            ),
            SizedBox(height: 20,),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                child: Text('완료', style: TextStyle(color: Colors.white, fontSize: 20),),
                onPressed: allconsend == true ? (){
                  Navigator.pushNamed(context, Joinmembership.routeName);
                } : null,            
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
