import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:user_managment_firebase/app/modules/home/views/home_view.dart';
import 'package:user_managment_firebase/app/modules/login_page/views/login_page_view.dart';

import '../controllers/authentication_controller.dart';

class AuthenticationView extends GetView<AuthenticationController> {
  final authServices =Get.put(AuthenticationController());
  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: firebaseAuth.authStateChanges(),
        builder: (context,snapshot){
          if (snapshot.connectionState==ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(),);
          }
         else if (snapshot.hasError) {
            return Center(child: Text("SOMETHING WENT WRONG"));
          }
          else if(snapshot.hasData){
            return HomeView();
          }else{
            return LoginPageView();
          }
        }),
    );
  }
}
