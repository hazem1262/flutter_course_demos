import 'package:flutter_day2_demo/models/post.dart';
import 'package:flutter_day2_demo/services/post_service.dart';

class PostRepository{
  PostService _postService = PostService();

  Future<List<Post>> fetchPosts(){
    return _postService.fetchPosts();
  }
}