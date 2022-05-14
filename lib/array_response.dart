import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_day2_demo/model/post.dart';
import 'package:http/http.dart' as http;

class ArrayResponse extends StatefulWidget {
  final String title;

  const ArrayResponse({Key key, this.title}) : super(key: key);
  @override
  _ArrayResponseState createState() => _ArrayResponseState();
}

class _ArrayResponseState extends State<ArrayResponse> {
  Future<List<Post>> futurePosts;
  /*
* Although it’s convenient, it’s not recommended to put an API call in a build() method.

Flutter calls the build() method every time it needs to change anything in the view,
*  and this happens surprisingly often.
*  Leaving the fetch call in your build() method floods the API with unnecessary calls
* and slows down your app.
* https://flutter.dev/docs/cookbook/networking/fetch-data

*/
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
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Text(post.title, textAlign: TextAlign.center,)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(post.body, textAlign: TextAlign.start,),
                          ),
                        ],
                      ),
                    ),
                  );
                }
            );
          } else if(snapshot.hasError){
            return Center(child: Text(snapshot.error),);
          }
          else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}



Future<List<Post>> fetchPosts() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/posts');
  if(response.statusCode == 200){
    print(response.body);
    var mappedResponse = json.decode(response.body) as List;
    List<Post> posts = mappedResponse.map((postResponse) => Post.fromJson(postResponse)).toList();
    // return (json.decode(response.body) as List).map((e) => Post.fromJson(e)).toList();
    // return List<Post>.from((json.decode(response.body) as List).map((e) => Post.fromJson((e)))).toList();
    return posts;
  }else {
    throw Exception('FAILED TO LOAD POST');
  }
}