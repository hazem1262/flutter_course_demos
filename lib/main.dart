import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_day2_demo/model/post.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Networking Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Networking Demo'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: FutureBuilder<List<Post>>(
        future: fetchPosts(),
        builder: (context, snapshot){
          print("snapshot error:" + snapshot.error.toString());
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
