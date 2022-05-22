import 'package:flutter/material.dart';
import 'package:flutter_day2_demo/models/post.dart';

@immutable
abstract class PostsState {
  final List<Post> posts;
  final bool isLoading;
  final Exception e;
  PostsState({this.isLoading = false, this.posts, this.e, });
}

class PostsLoading extends PostsState {
  PostsLoading() : super(isLoading: true);
}

class PostsFailure extends PostsState {
  final Exception e;
  PostsFailure({this.e}) : super(e: e);
}

class PostsSuccess extends PostsState{
  final List<Post> posts;
  PostsSuccess({this.posts}) : super(posts: posts);
}