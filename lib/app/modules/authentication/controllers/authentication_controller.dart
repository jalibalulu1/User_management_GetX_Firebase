// import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:user_managment_firebase/app/modules/model/user_model.dart';
import 'package:user_managment_firebase/app/modules/signup_page/controllers/signup_page_controller.dart';

class AuthenticationController extends GetxController {
  static AuthenticationController instance = Get.find();
  final signupcontroller = Get.put(SignupPageController());
  // late Rx<User?>
  //     user; // to initialise our firebase model here.we declare variable of firebase user.includes email,name,password...
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  //   user = Rx<User?>(auth.currentUser);
  //   user.bindStream(auth
  //       .userChanges()); //whenever changes in the user takesplace(logedin,logged out)then user /instance would be notified bcos of bind widget.
  //   ever(user, _initialScreen);
  // }

  //To check if user logged in or not
  // _initialScreen(User? user) {
  //   if (user == null) {
  //     Get.to(LoginPageView());
  //   } else {
  //     // Get.snackbar(
  //     //     'Successfull', 'You have successfully logged in to your account',
  //     //     backgroundColor: Colors.green,
  //     //     snackPosition: SnackPosition.BOTTOM,
  //     //     duration: Duration(seconds: 1));
  //     Get.to(HomeView());
  //   }
  // }

  Future register( ) async {
    if (signupcontroller.formkey.currentState!.validate()) {
      try {
      final result= await auth.createUserWithEmailAndPassword(
            email: signupcontroller.emailSignupcontroller.text.trim(), password: signupcontroller.passwordSignupcontroller.text.trim());
            User resultUser=result.user!;
        final userData = Users(
            id: result.user!.uid,
            name: signupcontroller.nameSignupcontroller.text,
            email: signupcontroller.emailSignupcontroller.text,
            age: signupcontroller.ageSignupcontroller.text,
            occupation: signupcontroller.occupationSignupcontroller.text,
            img:img);

        createUser(users: userData,id: resultUser.uid);

        Get.snackbar("About Sign up", "Sign up message",
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.BOTTOM,
            messageText: Text(
              "SUCESSFULLY REGISTERED",
              style: TextStyle(color: Colors.white),
            ),
            titleText: Text(
              "",
              style: TextStyle(color: Colors.white),
            ));
            
      }on FirebaseAuthException catch (e) {
        Get.snackbar("About Sign up", "Sign up message",
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM,
            messageText: Text(
              e.message.toString(),
              style: TextStyle(color: Colors.white),
            ),
            titleText: Text(
              "Account creation failed",
              style: TextStyle(color: Colors.white),
            ));
      }
    }
  }

  void login(GlobalKey<FormState> formkey1, String email, password) async {
    if (formkey1.currentState!.validate()) {
      try {
        await auth.signInWithEmailAndPassword(email: email, password: password);
      }on FirebaseAuthException catch (e) {
        Get.snackbar("About Login", "Login message",
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM,
            messageText: Text(
              e.message.toString(),
              style: TextStyle(color: Colors.white),
            ),
            titleText: Text(
              "Login failed",
              style: TextStyle(color: Colors.white),
            ));
      }
    }
  }

  

  createUser({required Users users,dynamic id}) async {
    //Reference to document
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    // print("Docuser id of user :${docUser.id}");
    users.userid=docUser.id;
    users.id = id;
    final json = users.toJson();
    //Create document and write data toFirebase
    await docUser.set(json);
  }

  // Stream<Iterable<Users>> readUsers() =>
  //     FirebaseFirestore.instance.collection('users').snapshots().map(
  //         (snapshot) => snapshot.docs.map((doc) => Users.fromJson(doc.data())));

  void logout() async {
    await auth.signOut();
  }


  @override
  void onClose() {}
}
