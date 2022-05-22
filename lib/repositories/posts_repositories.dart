import 'package:flutter_day2_demo/models/post.dart';
import 'package:flutter_day2_demo/services/posts_service.dart';

class PostsRepositories{
  PostsService _postsService = PostsService();

  Future<List<Post>> fetchPosts(){
    return _postsService.fetchPosts();
  }
}