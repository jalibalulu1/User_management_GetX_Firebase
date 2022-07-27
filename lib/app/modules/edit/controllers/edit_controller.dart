import 'dart:convert';

import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';




  File? image;
String img = '';
class EditController extends GetxController {

  //TODO: Implement EditController
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
    }
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
