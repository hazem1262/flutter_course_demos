import 'package:flutter_day2_demo/local_storage/db_helper.dart';

class Post{
  int userId;
  int id;
  String title;
  String body;
  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json){
    return Post(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      DbHelper.COLUMN_ID:id,
      DbHelper.COLUMN_USER_ID:userId,
      DbHelper.COLUMN_TITLE:title,
      DbHelper.COLUMN_BODY:body,
    };
  }
}