import 'dart:convert';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:user_managment_firebase/app/modules/authentication/views/authentication_view.dart';
import 'package:user_managment_firebase/app/modules/home/views/home_view.dart';
import 'package:user_managment_firebase/app/modules/model/user_model.dart';
import 'package:user_managment_firebase/app/modules/signup_page/controllers/signup_page_controller.dart';

import '../controllers/edit_controller.dart';

EditController editController = Get.put(editController);

String img = '';
SignupPageController signupPageController = Get.put(signupPageController);

class EditView extends GetView<EditController> {
  // SignupPageController signupPageController=Get.
  dynamic data;
  EditView({this.data});
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final occupationController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = data['name'];
    ageController.text = data["age"];
    occupationController.text = data["occupation"];
    emailController.text = data["email"];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      // appBar: AppBar(
      //   iconTheme: IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
      //   backgroundColor: Colors.transparent,

      //   elevation: 0, // make it transparent
      //   centerTitle: true,
      // ),
      // extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Container(
            height: 1000,
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("asset/images/bg_img.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 2.0),
                          child: Container(
                            width: 400,
                            height: 650,
                            // width: MediaQuery.of(context).size.width * 0.9,
                            // height: MediaQuery.of(context).size.height * 0.8,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255)
                                    .withOpacity(0.15),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: Color.fromARGB(255, 255, 255, 255)
                                      .withOpacity(0.15),
                                )),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: SizedBox(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(60),
                                          ),
                                          child: CircleAvatar(
                                            radius: 60,
                                            backgroundImage: MemoryImage(
                                                Base64Decoder()
                                                    .convert(data['img'])),
                                          )),
                                      IconButton(
                                          onPressed: (() {
                                            signupPageController.getImage();
                                          }),
                                          icon: Icon(
                                              Icons.photo_library_outlined)),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        child: Card(
                                          color: Colors.transparent,
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: TextFormField(
                                                controller: nameController,
                                                style: TextStyle(
                                                    color: Colors.white),
                                                decoration: InputDecoration(
                                                  prefixIcon: Icon(
                                                    Icons.person,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                                      SizedBox(
                                        child: Card(
                                          color: Colors.transparent,
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: TextFormField(
                                                controller: ageController,
                                                style: TextStyle(
                                                    color: Colors.white),
                                                decoration: InputDecoration(
                                                  prefixIcon: Icon(
                                                    Icons.numbers_sharp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                                      SizedBox(
                                        child: Card(
                                          color: Colors.transparent,
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: TextFormField(
                                                controller:
                                                    occupationController,
                                                style: TextStyle(
                                                    color: Colors.white),
                                                decoration: InputDecoration(
                                                  prefixIcon: Icon(
                                                    Icons.work,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                                      SizedBox(
                                        child: Card(
                                          color: Colors.transparent,
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: TextFormField(
                                                controller: emailController,
                                                style: TextStyle(
                                                    color: Colors.white),
                                                decoration: InputDecoration(
                                                  prefixIcon: Icon(
                                                    Icons.email,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 12,
                                          ),
                                          ElevatedButton(
                                            onPressed: () async {
                                              await FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(data['userid'])
                                                  .update({
                                                'name':
                                                    nameController.text.trim(),
                                                ' age':
                                                    ageController.text.trim(),
                                                'occupation':
                                                    occupationController.text
                                                        .trim(),
                                                'email':
                                                    emailController.text.trim(),
                                                // 'img': img
                                              });

                                              Get.off(AuthenticationView());
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: Color.fromARGB(
                                                        255, 18, 221, 25)
                                                    .withOpacity(0.3),
                                                textStyle: TextStyle(
                                                    fontSize: 30,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            child: Text(
                                              'Updated',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
            )),
      ),
    );
  }
}
