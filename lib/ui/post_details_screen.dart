import 'package:flutter/material.dart';
import 'package:flutter_day2_demo/models/post.dart';

class PostDetailsScreen extends StatelessWidget {
  final Post post;

  const PostDetailsScreen({Key key, this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context, "test navigation");
          },
        ),
        title: Text("Post details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("Post id: ${post.id}"),
            SizedBox(height: 12,),
            Text("Post user id: ${post.userId}"),
            SizedBox(height: 12,),
            Text("Post title: ${post.title}"),
            SizedBox(height: 12,),
            Text("Post body: ${post.body}"),
          ],
        ),
      ),
    );
  }
}
