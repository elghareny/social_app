
import 'package:flutter/cupertino.dart';

class UserModel
{
  String? uId;
  String? email;
  String? name;
  String? phone;
  String? image;
  String? cover;
  String? bio;

  UserModel({
    required this.uId,
    required this.name,
    required this.phone,
    required this.email,
    required this.image,
    required this.cover,
    required this.bio,
});

  UserModel.fromJson(Map<String,dynamic> json)
  {
    email = json['email'];
    phone = json['phone'];
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
  }


  Map<String,dynamic> toMap()
  {
    return {
      'name' :name,
      'phone' :phone,
      'email' :email,
      'uId' :uId,
      'image' :image,
      'cover' :cover,
      'bio' :bio,
    };
  }
}