import 'package:get/get.dart';

import '../controllers/profileview_controller.dart';

class ProfileviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileviewController>(
      () => ProfileviewController(),
    );
  }
}
