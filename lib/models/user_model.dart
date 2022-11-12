import 'dart:math';

class UserModel
{
  String? uId;
  String? email;
  String? name;
  String? phone;
  String? image;
  String? cover;
  String? bio;

  UserModel(
    this.uId,
    this.name,
    this.phone,
    this.email,
    this.image,
    this.cover,
    this.bio,
  );

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