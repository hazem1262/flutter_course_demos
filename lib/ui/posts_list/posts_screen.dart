import 'package:flutter_day2_demo/ui/posts_list/posts_bloc.dart';
import 'package:flutter_day2_demo/ui/posts_list/posts_state.dart';
import 'package:flutter_day2_demo/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsScreen extends StatelessWidget {
  PostsScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state){
          if(state is PostsSuccess){
            final posts = state.posts;
            return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (ctx, index){
                  final post = posts[index];
                  return PostWidget(post: post,);
                }
            );
          } else if(state is PostsInitial){
            return Center(child: CircularProgressIndicator());
          } else{
            return Center(child: Text("Some thing went wrong"));
          }
        },
      ),
    );
  }

}


