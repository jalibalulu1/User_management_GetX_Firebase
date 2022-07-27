import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:user_managment_firebase/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:user_managment_firebase/app/modules/profileview/views/profileview_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {

  final FirebaseAuth auth=FirebaseAuth.instance ;
  @override
  Widget build(BuildContext context) {
  final User? currentUser = auth.currentUser;
  // print(currentUser!.uid);
    return Scaffold(
      
    
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
        backgroundColor: Colors.transparent,
        title: Text(
        currentUser!.email!,
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
        ),
         elevation: 0, // make it transparent
        centerTitle: true,
      ),
       extendBodyBehindAppBar: true,

    
      drawer: Drawer(
        backgroundColor:Color.fromARGB(255, 172, 236, 247),
        shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
        child: Column(
          children: [
            DrawerHeader(
              child:
                Center(child: Text(currentUser.email!)),
             ),
            ListTile(
              leading: Icon(Icons.message_outlined),
              title: Text('Message'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            GestureDetector(
              onTap: () => AuthenticationController.instance.logout(),
              child: ListTile(
                leading: Icon(Icons.exit_to_app_outlined),
                title: Text('Log out'),
              ),
            ),
          ],
        ),
      ),
      
      body: Container(
       
       decoration:  BoxDecoration(
          image: DecorationImage(
              image:  AssetImage("asset/images/bg_img.jpg"),
               fit: BoxFit.cover,
          ),),child:
         
         StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print('Error loading the data from firestore');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                    backgroundColor: Colors.white),
              );
            }
            final List userList = [];
            snapshot.data!.docs.map(
              (documentSnapshot) {
                Map temp = documentSnapshot.data() as Map<String, dynamic>;
                userList.add(temp);
            
              },
            ).toList();
            return ListView.separated(
                itemBuilder: ((context, index) {
           
                  final data = userList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async{
                    //  final user= await Users(name: data[index]['name'], email:  data[index]['email'], age: data[index]['age'], occupation:  data[index]['occupation'],id:data[index]['ids'] );

                         Get.to(()=>ProfileviewView(
                        data: data,
                         
                         ));
                      },
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.15),
                                )),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: SizedBox(
                                 
                                  child: Text(
                                    data["name"],
                                    style: TextStyle(fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10,
                  );
                },
                itemCount: userList.length);
          },
        ),
      ),
    );
  }

 
}
