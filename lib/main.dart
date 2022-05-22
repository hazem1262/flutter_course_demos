import 'package:flutter/material.dart';
import 'package:flutter_day2_demo/ui/posts_list/posts_bloc.dart';
import 'package:flutter_day2_demo/ui/posts_list/posts_event.dart';
import 'package:flutter_day2_demo/ui/posts_list/posts_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      home: BlocProvider(
        create: (context) => PostsBloc()..add(PostsFetched()),
        child: PostsScreen(title: 'Flutter Networking Demo')
      ),
    );
  }
}