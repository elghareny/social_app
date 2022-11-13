
import 'package:flutter/cupertino.dart';

class PostModel
{
  String? uId;
  String? name;
  String? image;
  String? dateTime;
  String? text;
  String? psotImage;

  PostModel({
    required this.uId,
    required this.name,
    required this.image,
    required this.dateTime,
    required this.text,
    required this.psotImage,

});

  PostModel.fromJson(Map<String,dynamic> json)
  {

    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
    psotImage = json['psotImage'];

  }


  Map<String,dynamic> toMap()
  {
    return {
      'name' :name,
      'uId' :uId,
      'image' :image,
      'dateTime' :dateTime,
      'text' :text,
      'psotImage' :psotImage,
    };
  }
}