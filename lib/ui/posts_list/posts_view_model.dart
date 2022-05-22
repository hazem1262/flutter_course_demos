import 'package:flutter_day2_demo/repositories/posts_repositories.dart';
import 'package:flutter_day2_demo/ui/posts_list/posts_state.dart';
import 'package:riverpod/riverpod.dart';

final postsViewModelProvider = StateNotifierProvider<PostsViewModel, PostsState>((ref) {
  return PostsViewModel(ref.watch(postsRepositoryProvider));
});

class PostsViewModel extends StateNotifier<PostsState> {
  PostsViewModel(this._postsRepositories): super(PostsLoading());

  PostsRepositories _postsRepositories = PostsRepositories();

  void fetchPosts() async {
    state = PostsLoading();
    final posts = await _postsRepositories.fetchPosts();
    state = PostsSuccess(posts: posts);
  }
}