import 'package:flutter_day2_demo/models/post.dart';

abstract class PostsState{}

class PostsInitial extends PostsState {}

class PostsFailure extends PostsState {}

class PostsSuccess extends PostsState{
  final List<Post> posts;

  PostsSuccess({this.posts});

}