import 'package:flutter_day2_demo/local_storage/db_helper.dart';
import 'package:flutter_day2_demo/models/post.dart';
import 'package:flutter_day2_demo/services/post_service.dart';
import 'package:connectivity/connectivity.dart';

class PostRepository{
  PostService _postService = PostService();

  // check if there a network, if not return saved results from data base
  Future<List<Post>> fetchPosts() async{
    // get the network status
    var connectivityResult = await (Connectivity().checkConnectivity());
    final dbHelper = DbHelper.instance;
    // if there is not a network, return saved posts in db
    if(connectivityResult == ConnectivityResult.none){
      final savedPosts = await dbHelper.queryAllRows();
      return List<Post>.from(savedPosts.map((savedPost) => Post.fromJson(savedPost)));
    } else{
      final posts = await _postService.fetchPosts();
      for(final post in posts){
        dbHelper.insert(post.toMap());
      }
      return posts;
    }
  }
}