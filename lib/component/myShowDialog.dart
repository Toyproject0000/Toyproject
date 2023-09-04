import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class MyShowDialog {
  final BuildContext context;
  final Function(String imagePath) changeImagePath;


  MyShowDialog({required this.context, required this.changeImagePath});

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  Future<void> pickImageOfGallery() async {
    final imagePicker = ImagePicker();
    final galleryFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (galleryFile != null) {
      final img = await _cropImage(imageFile: File(galleryFile.path));
      Navigator.pop(context);
      if (img == null) {
      } else {
          changeImagePath(img.path);
      }
    }
  }

  void SelectbasicImage() {

    changeImagePath('');
  }

  Future<void> pickImageOfCamera() async {
    final imagePicker = ImagePicker();
    final cameraFile = await imagePicker.pickImage(source: ImageSource.camera);

    if (cameraFile != null) {
      final img = await _cropImage(imageFile: File(cameraFile.path));

      Navigator.pop(context);
      if (img == null) {
      } else {
        changeImagePath(img.path);
      }
    }
  }

  void showMenuOfPicture() {
    showModalBottomSheet(
        context: context,
        builder: ((context) => Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      pickImageOfCamera();
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.photo_camera_rounded),
                          SizedBox(width: 18),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Camera',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      decoration: TextDecoration.none,
                                    )),
                                Text('카메라로 사진찍기',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      decoration: TextDecoration.none,
                                    ))
                              ]),
                        ],
                      ),
                    ),
                  )),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      pickImageOfGallery();
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.image),
                          SizedBox(width: 20),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Gallery',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      decoration: TextDecoration.none,
                                    )),
                                Text('갤러리에서 사진 가져오기',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      decoration: TextDecoration.none,
                                    ))
                              ]),
                        ],
                      ),
                    ),
                  )),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      SelectbasicImage();
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.account_circle),
                          SizedBox(width: 20),
                          Text('기본사진 설정',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                decoration: TextDecoration.none,
                              )),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            )));
  }

}