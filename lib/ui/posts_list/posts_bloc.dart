import 'package:flutter_day2_demo/repositories/posts_repositories.dart';
import 'package:flutter_day2_demo/ui/posts_list/posts_event.dart';
import 'package:flutter_day2_demo/ui/posts_list/posts_state.dart';
import 'package:bloc/bloc.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState>{
  PostsBloc() : super(PostsInitial());

  PostsRepositories _postsRepositories = PostsRepositories();

  @override
  Stream<PostsState> mapEventToState(PostsEvent event) async* {
    if(event is PostsFetched){
      final posts = await _postsRepositories.fetchPosts();
      yield PostsSuccess(posts:posts);
    }
  }

}