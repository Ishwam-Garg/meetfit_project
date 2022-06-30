//@dart=2.9
import 'package:flutter/material.dart';


class Profile {
  final String uid;
  final String name;
  final String about;
  final String email;

  Profile({
    this.uid,
    this.name,
    this.about,
    this.email,
});

  Map<String,dynamic> toJson() =>{
    'name' : name,
    'about': about,
    'email' : email,
    'uid': uid,
  };

  static Profile fromJson(Map<String,dynamic> json)=>Profile(
      uid: json['id'],
      name: json['name'],
      about: json['about'],
      email: json['email']
  );
}