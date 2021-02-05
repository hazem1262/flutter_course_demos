import 'dart:convert';
import 'package:flutter_day2_demo/widgets/post_widget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_day2_demo/models/post.dart';

class PostsScreen extends StatefulWidget {
  PostsScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

/*
* Although it’s convenient, it’s not recommended to put an API call in a build() method.

Flutter calls the build() method every time it needs to change anything in the view,
*  and this happens surprisingly often.
*  Leaving the fetch call in your build() method floods the API with unnecessary calls
* and slows down your app.
* https://flutter.dev/docs/cookbook/networking/fetch-data

*/
class _PostsScreenState extends State<PostsScreen> {
  Future<List<Post>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Post>>(
        future: futurePosts,
        builder: (context, snapshot){
          if(snapshot.hasData){
            final posts = snapshot.data;
            return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (ctx, index){
                  final post = posts[index];
                  return PostWidget(post: post,);
                }
            );
          } else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}


Future<List<Post>> fetchPosts() async{
  final response = await http.get('https://jsonplaceholder.typicode.com/posts');
  if(response.statusCode == 200){
    print(response.body);
    // return (json.decode(response.body) as List).map((e) => Post.fromJson(e)).toList();
    return List<Post>.from((json.decode(response.body) as List).map((e) => Post.fromJson((e)))).toList();
  }else{
    throw Exception('FAILED TO LOAD POST');
  }
}
