import 'dart:convert';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:user_managment_firebase/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:user_managment_firebase/app/modules/edit/views/edit_view.dart';
import 'package:user_managment_firebase/app/modules/model/user_model.dart';

import '../controllers/profileview_controller.dart';

class ProfileviewView extends GetView<ProfileviewController> {
  dynamic data;
  var images;

  ProfileviewView({this.data});

  @override
  Widget build(BuildContext context) {
    final encoding = data['img'];
    images = const Base64Decoder().convert(encoding);
    // print(FirebaseAuth.instance.currentUser!.uid);
    // print("from data ${data['id']}");
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
        backgroundColor: Colors.transparent,
        title: Text(
          data['email'],
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
        ),
        elevation: 0, // make it transparent
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("asset/images/bg_img.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: InkWell(
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 2.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.7,
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
                              CircleAvatar(
                                radius: 60,
                                backgroundImage: MemoryImage(images),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                child: Card(
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(children: [
                                      Text(
                                        'Name : ',
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        data['name'],
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                child: Card(
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(children: [
                                      Text(
                                        'Age : ',
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        data['age'],
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                child: Card(
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(children: [
                                      Text(
                                        'Occupation : ',
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        data['occupation'],
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                child: Card(
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(children: [
                                      Text(
                                        'Email : ',
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        data['email'],
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              FirebaseAuth.instance.currentUser?.uid ==
                                      data['id']
                                  ? Column(children: [
                                      SizedBox(
                                        height: 12,
                                      ),
                                      ElevatedButton(
                                          onPressed: () async {
                                            Get.to(() => EditView(
                                                  data: data,
                                                ));
                                            data['img'];
                                          },
                                          style: ElevatedButton.styleFrom(
                                              primary: Color.fromARGB(
                                                      255, 18, 221, 25)
                                                  .withOpacity(0.3),
                                              textStyle: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold)),
                                          child: Text(
                                            'Edit',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                            ),
                                          )),
                                    ])
                                  : SizedBox(
                                      height: 10,
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
          )),
    );
  }
}
