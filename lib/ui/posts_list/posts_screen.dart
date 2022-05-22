import 'package:flutter_day2_demo/ui/posts_list/posts_view_model.dart';
import 'package:flutter_day2_demo/ui/posts_list/posts_state.dart';
import 'package:flutter_day2_demo/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsScreen extends ConsumerStatefulWidget {
  PostsScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return PostsScreenState();
  }
}

class PostsScreenState extends ConsumerState {
  @override
  void initState() {
    super.initState();
    ref.read(postsViewModelProvider.notifier).fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    PostsState state = ref.watch(postsViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text((widget as PostsScreen).title),
      ),
      body: state.isLoading ? Center(child: CircularProgressIndicator()) :
      state.e != null ? Center(child: Text("Some thing went wrong")) :
      ListView.builder(
          itemCount: state.posts.length,
          itemBuilder: (ctx, index){
            final post = state.posts[index];
            return PostWidget(post: post,);
          }
      ),
    );
  }
}


