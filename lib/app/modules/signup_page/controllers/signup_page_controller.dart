import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

File? image;
String img = '';

class SignupPageController extends GetxController {
  //TODO: Implement SignupPageController
  final formkey = GlobalKey<FormState>();
  final emailSignupcontroller = TextEditingController();
  final passwordSignupcontroller = TextEditingController();
  final nameSignupcontroller = TextEditingController();
  final ageSignupcontroller = TextEditingController();
  final occupationSignupcontroller = TextEditingController();


  Future getCameraImage() async {
     final pimage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pimage == null) {
      return;
    } else {
      image = File(pimage.path);
      update();
      final bytes = File(pimage.path).readAsBytesSync();
      img = base64Encode(bytes);
    }
  }
  Future getImage() async {
    final pimage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pimage == null) {
      return;
    } else {
      image = File(pimage.path);
      update();
      final bytes = File(pimage.path).readAsBytesSync();
      img = base64Encode(bytes);
    }  Get.back();
  }
  Future clear()async{
    emailSignupcontroller.clear();
    nameSignupcontroller.clear();
    ageSignupcontroller.clear();
    passwordSignupcontroller.clear();
    occupationSignupcontroller.clear();
    img='';
    
  }
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
