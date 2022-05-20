import 'dart:convert';

import 'package:flutter_day2_demo/models/post.dart';
import 'package:http/http.dart' as http;

class PostService {
  Future<List<Post>> fetchPosts() async {
    final response = await http.get('https://jsonplaceholder.typicode.com/posts');
    if(response.statusCode == 200) {
      print(response.body);
      // return (json.decode(response.body) as List).map((e) => Post.fromJson(e)).toList();
      return List<Post>.from((json.decode(response.body) as List).map((e) => Post.fromJson((e)))).toList();
    } else {
      throw Exception('FAILED TO LOAD POST');
    }
  }
}