import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:user_managment_firebase/app/modules/authentication/controllers/authentication_controller.dart';

import 'package:user_managment_firebase/app/modules/signup_page/views/signup_page_view.dart';

import '../controllers/login_page_controller.dart';
 
class LoginPageView extends GetView<LoginPageController> {
  final formkey1=GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //  crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(14),
              // width: MediaQuery.of(context).size.width,
              child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Login',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.black54),),
                  ),
                  SizedBox(height: 10,),
                  Form(
                    key:formkey1,
                    child:Column(children: [
                      TextFormField(
                      controller: emailcontroller,
                      validator: (value) {
                      return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!)?null:'Please provide a valid email id';
                    },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),

                        hintText: 'Enter your email',
                      
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
                    
                      controller: passwordcontroller,
                       validator: (value){
                        if(value!.isEmpty){
                          return 'Password cannot be empty';
                        }else{
                          return null;
                        }
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                       
                        prefixIcon: Icon(Icons.key_outlined),
                        

                        hintText: 'Enter your password',
                        
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                  ),
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
                      onPressed: () {
                        AuthenticationController.instance.login(formkey1, emailcontroller.text.trim() , passwordcontroller.text.trim());
                            // Get.off(HomeView());
                          
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),

                    ],)),
                  
                  // SizedBox(
                  //   height: 5,
                  // ),
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //       width: MediaQuery.of(context).size.width / 1.7,
                  //     ),
                  //     TextButton(
                  //       onPressed: () {},
                  //       child: Text(
                  //         'Forgot password ?',
                  //         style: TextStyle(
                  //           color: Colors.blue,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 6,
                  // ),
                  // Center(
                  //     child: Text(
                  //   'OR',
                  //   style: TextStyle(
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.w500,
                  //       color: Colors.grey.shade500),
                  // )),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account yet ?",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade500),
                      ),
                      TextButton(
                        child: Text(
                          'Sign up.',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600),
                        ),
                        onPressed: ((() async{
                        
                          Get.to( SignupPageView());
                        
                        
                        }
                        )
                         
                      ))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
