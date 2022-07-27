import 'package:firebase_auth/firebase_auth.dart';

class Users{
  String? id;
  final String name;
  final String age;
  final String occupation;
  final String img;
  String? userid;

  final String email;
  // final String? password;

  Users({this.id,this.userid,required this.name,required this.email,required this.age,required this.occupation,required this.img});
  Map <String,dynamic>toJson()=>{
    'id':id,
    'userid':userid,
    'name':name,
    'age':age,
    'occupation':occupation,
    'email':email,
    'img':img
  
  };
  // static Users fromJson(Map<String,dynamic> json)=>Users(
  //   id:json['id'],
  //   name:json['name'],
  //   age:json['age'],
  //   occupation:json['occupation'],
  //   email:json['email']
  // );

}