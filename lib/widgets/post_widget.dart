import 'package:flutter/material.dart';
import 'package:flutter_day2_demo/models/post.dart';
import 'package:flutter_day2_demo/ui/post_details_screen.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key key, this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        final results = await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => PostDetailsScreen(post: post,)
            )
        );
        if(results != null){
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text("$results")));
        }
      },
      child: Padding(
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
      ),
    );;
  }
}
