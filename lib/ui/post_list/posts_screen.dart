import 'package:flutter_day2_demo/ui/post_list/post_list_provider.dart';
import 'package:flutter_day2_demo/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_day2_demo/models/post.dart';
import 'package:provider/provider.dart';

class PostsScreen extends StatelessWidget {
  PostsScreen({Key key, this.title}) : super(key: key);

  final String title;
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: ChangeNotifierProvider<PostsProvider>(
        create: (context) => PostsProvider(),
        child: Consumer<PostsProvider>(
          builder: (buildContext, postProvider, _){
            return (postProvider.posts != null)?
             ListView.builder(
                itemCount: postProvider.posts.length,
                itemBuilder: (ctx, index){
                  final post = postProvider.posts[index];
                  return PostWidget(post: post,);
                }
            ): Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

}
