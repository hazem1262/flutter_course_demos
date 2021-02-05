import 'package:flutter/material.dart';
import 'package:flutter_day2_demo/models/post.dart';
import 'package:flutter_day2_demo/repositories/post_repository.dart';

class PostsProvider extends ChangeNotifier{
  List<Post> posts;
  PostRepository _postRepository = PostRepository();

  PostsProvider(){
    getPosts();
  }

  void getPosts() {
    _postRepository.fetchPosts().then(
            (newPosts){
              posts = newPosts;
              notifyListeners();
            }
    );
  }
}