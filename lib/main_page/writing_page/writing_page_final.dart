import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:provider/provider.dart';
import 'package:smart_dongne/component/myShowDialog.dart';
import 'package:smart_dongne/component/topicSelectWidget.dart';
import 'package:smart_dongne/main_page/writing_page/cover.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_dongne/provider/setPageData.dart';
import 'package:smart_dongne/provider/writingSettingProvider.dart';
import 'package:smart_dongne/server/Server.dart';
import 'package:smart_dongne/server/userId.dart';

class LastSetting extends StatefulWidget {
  const LastSetting({super.key});

  static const routeName = '/LastSetting';

  @override
  State<LastSetting> createState() => _LastSettingState();
}

class _LastSettingState extends State<LastSetting> {
  MyShowDialog? myShowDialog;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  List<bool> ButtonColorList = [];
  Color backGroundColor = Color(0xFF98DFFF);
  String title = '';
  late String contents;
  late GlobalKey<FlutterSummernoteState> summerNoteKey;
  dynamic finalImage; // 꾸밈까지 맞친 최종 이미지
  late File imageFile;
  late SetPageProvider _setPageProvider;
  late WritingSettingProvider _writingSettingProvder;
  String disclosureValue = '';  

  bool commentvalue = false;
  bool numberoflike = false;

  // topic Material
  String? SelectTopic;

  void ChangeTopic(String topic){
    SelectTopic = topic;
  }

  bool selectCover = false;

  String? imagePath;

  String? _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      return title;
    }
    return null;
  }

  // void disclosureState(String state){
  //   disclosureValue = state;
  // }

  void sendDateServer() async {
    final titleString = _tryValidation();

    if (titleString == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text('제목을 입력해주세요.'),
      ));
    } else if (selectCover == false) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text('표지를 선택해 주세요.'),
      ));
    } 
    else if (SelectTopic == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text('주제를 선택해주세요.'),
      ));
    } 
    else {
      final settingComment = commentFunc();
      final settingNumberofLike = likeNumberFunc();
      final tempDir = await getTemporaryDirectory();
      File file = await File('${tempDir.path}/image.png').create();
      final finalImageFile = await file.writeAsBytes(finalImage);
      // 서버에 데이터 보내기
      final data = {
        'userId': globalUserId,
        'root': LoginRoot,
        'title': titleString,
        'contents': contents,
        'category': SelectTopic!,
        'disclosure': disclosureValue,
        'possibleReply': settingComment,
        'token': jwtToken,
        'visiblyLike': settingNumberofLike
      };
      final response = await ServerSendImageDataTemplate(
          '/post/submit', data, finalImageFile.path);
      if (response == 'ok') {
        Navigator.pop(context);
        summerNoteKey.currentState!.setEmpty();
        _setPageProvider.ChangeScreen(0);
      }
    }
  }

  void changedImage(changedImagePath) async {
    setState(() {
        imagePath = changedImagePath;
        selectCover = true;
      });

      finalImage = await Navigator.pushNamed(context, CoverPage.routeName,
          arguments: ScreenArguments(imagePath!));
  }

  String commentFunc() {
    if (commentvalue == false) {
      return '활성화';
    } else {
      return '비활성화';
    }
  }

  String likeNumberFunc() {
    if (numberoflike == false) {
      return '활성화';
    } else {
      return '비활성화';
    }
  }

  @override
  void didChangeDependencies() {
    // argument allocation
    final args = ModalRoute.of(context)!.settings.arguments as Contents;
    contents = args.content;
    summerNoteKey = args.summerNoteKey;
    myShowDialog = MyShowDialog(context: context, changeImagePath: changedImage);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _writingSettingProvder = Provider.of<WritingSettingProvider>(context, listen: false);
    _setPageProvider = Provider.of<SetPageProvider>(context, listen: false);
    disclosureValue = Provider.of<WritingSettingProvider>(context).disclosure;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          '새 게시물',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              sendDateServer();
            },
            child: Text(
              '완료',
              style: TextStyle(
                color: Colors.blue[600],
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(color: Colors.grey, width: 1.0),
            )),
            child: Form(
              key: _formKey,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return '제목을 입력해주세요';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    title = value!;
                  });
                },
                maxLength: 40,
                controller: _controller,
                maxLines: null,
                decoration: InputDecoration(
                  counterText: "",
                  border: InputBorder.none,
                  hintText: '제목을 입력하시오.',
                  focusedBorder: InputBorder.none,
                ),
                cursorColor: Colors.black,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              myShowDialog!.showMenuOfPicture();
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              ))),
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '표지 선택하기',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Icon(Icons.arrow_forward_ios_outlined)
                ],
              ),
            ),
          ),
          TopicSelectWidget(SelectTopic: SelectTopic, ChangeTopic: ChangeTopic,),
          Container(
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(color: Colors.grey, width: 1.0),
            )),
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '공개 범위',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                Consumer(
                  builder: (context, value, child) {
                    return DropdownButton<String>(
                      value: Provider.of<WritingSettingProvider>(context).disclosure,
                      icon: Icon(
                        Icons.keyboard_arrow_down_outlined,
                      ),
                      items: Provider.of<WritingSettingProvider>(context).disclosureList.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: TextStyle(color: Colors.black),),
                        );
                      }).toList(),
                      onChanged: (String? newValue){
                        disclosureValue = newValue!;
                        _writingSettingProvder.selectDisclosure(newValue!);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(color: Colors.grey, width: 1.0),
              )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '댓글 기능 비활성화',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Consumer(
                    builder: (context, value, child) {
                      return Switch(
                        value: Provider.of<WritingSettingProvider>(context).enableComments,
                        onChanged: (onChanged) {
                          _writingSettingProvder.commentActivationState(onChanged);
                        },
                        activeTrackColor: Colors.blue,
                        activeColor: backGroundColor,
                      );
                    },
                  ),
                ],
              )),
          Container(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '좋아요 수 비공개',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Consumer(
                  builder: (context, value, child) {
                    return Switch(
                    value: Provider.of<WritingSettingProvider>(context).likeNumber,
                    onChanged: (onChanged) {
                      _writingSettingProvder.selectlikeNumber(onChanged);
                    },
                    activeTrackColor: Colors.blue,
                    activeColor: backGroundColor,
                    );
                  } ,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Contents {
  final String content;
  final GlobalKey<FlutterSummernoteState> summerNoteKey;

  Contents(this.content, this.summerNoteKey);
}
