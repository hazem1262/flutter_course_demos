import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SingleObjectResponse extends StatefulWidget {
  final String title;

  const SingleObjectResponse({Key key, this.title}) : super(key: key);
  @override
  _SingleObjectResponseState createState() => _SingleObjectResponseState();
}

class _SingleObjectResponseState extends State<SingleObjectResponse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: FutureBuilder<dynamic>(
        future: fetchPosts(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(snapshot.data['userId'].toString()),
                      Text(snapshot.data['id'].toString()),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(snapshot.data['title']),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(snapshot.data['body']),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

Future<dynamic> fetchPosts() async{
  var response = await http.get('https://jsonplaceholder.typicode.com/posts/1');
  return json.decode(response.body);
}
