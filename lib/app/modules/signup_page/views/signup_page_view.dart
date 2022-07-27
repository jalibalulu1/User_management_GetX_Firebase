import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:user_managment_firebase/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:user_managment_firebase/app/modules/login_page/views/login_page_view.dart';
import 'package:user_managment_firebase/app/modules/model/user_model.dart';

import '../controllers/signup_page_controller.dart';

class SignupPageView extends GetView<SignupPageController> {
  final signupPageController = Get.put(SignupPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(14),
              // width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Form(
                      key: signupPageController.formkey,
                      child: Column(
                        children: [
                          GetBuilder<SignupPageController>(
                            builder: (controller) {
                              return Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  child: img.trim().isNotEmpty
                                      ? CircleAvatar(
                                          backgroundImage: MemoryImage(
                                              Base64Decoder().convert(img)),
                                        )
                                      :
                                      // image: const DecorationImage(
                                      //   image: AssetImage('asset/images/avatar copy.png'),
                                      // )
                                      Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(60),
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'asset/images/avatar copy.png')
                                                      )
                                                      )));
                            },
                          ),
                          IconButton(
                              onPressed: () async {
                                Get.defaultDialog(
                                    title: 'Choose',
                                    content: Column(
                                      children: [
                                        IconButton(
                                            onPressed: (() {
                                              signupPageController
                                                  .getCameraImage();
                                                 
                                              Get.back();
                                            }),
                                            icon: Icon(Icons.camera)),
                                        IconButton(
                                            onPressed: (() {
                                              signupPageController.getImage();
                                               
                                              Get.back();
                                            }),
                                            icon: Icon(
                                                Icons.photo_library_outlined))
                                      ],
                                    ));
                              },
                              icon: const Icon(Icons.add_a_photo)),
                          TextFormField(
                              controller:
                                  signupPageController.nameSignupcontroller,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Name cannot be empty';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),

                                hintText: 'Enter your name',
                                // labelText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 18,
                          ),
                          TextFormField(
                              controller:
                                  signupPageController.ageSignupcontroller,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Age cannot be empty';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.numbers),

                                hintText: 'Enter your age',
                                // labelText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 18,
                          ),
                          TextFormField(
                              controller: signupPageController
                                  .occupationSignupcontroller,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Occupation cannot be empty';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.work),

                                hintText: 'Enter your Occupation',
                                // labelText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 18,
                          ),
                          TextFormField(
                              controller:
                                  signupPageController.emailSignupcontroller,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Email cannot be empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                hintText: 'Enter your email',
                                // labelText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 18,
                          ),
                          TextFormField(
                              controller:
                                  signupPageController.passwordSignupcontroller,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Password cannot be empty';
                                } else {
                                  return null;
                                }
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.key_outlined),

                                hintText: 'Enter your password',
                                // labelText: 'Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 18,
                          ),
                          Container(
                            // width: MediaQuery.of(context).size.width * 2,
                            width: 390,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.blue,
                            ),
                            child: TextButton(
                              onPressed: (() async {
                                await AuthenticationController.instance
                                    .register();
                                // await AuthenticationController.instance.createUser(users:user);

                                // Get.off(LoginPageView());
                                signupPageController.clear();
                               
                              }),
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account ?",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade500),
                      ),
                      TextButton(
                        onPressed: (() {
                          signupPageController.clear();
                          Get.back();
                        }),
                        child: Text(
                          'Login here.',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
