import 'package:flutter/material.dart';
import 'package:flutter_day2_demo/model/movie.dart';
import 'package:http/http.dart' as http;

class NestedObjectResponse extends StatefulWidget {
  final String title;

  const NestedObjectResponse({Key key, this.title}) : super(key: key);
  @override
  _ArrayResponseState createState() => _ArrayResponseState();
}

class _ArrayResponseState extends State<NestedObjectResponse> {
  Future<List<Movie>> futureMovies;
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
    futureMovies = fetchMovies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Movie>>(
        future: futureMovies,
        builder: (context, snapshot){
          if(snapshot.hasData){
            final movies = snapshot.data;
            return ListView.builder(
                itemCount: movies.length,
                itemBuilder: (ctx, index){
                  final movie = movies[index];
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
                            child: Center(child: Text(movie.title, textAlign: TextAlign.center,)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(movie.genre.join(', '), textAlign: TextAlign.start,),
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



Future<List<Movie>> fetchMovies() async {
  var url = Uri.parse('https://api.androidhive.info/json/movies.json');
  final response = await http.get(url);
  if(response.statusCode == 200){
    print(response.body);
    return movieFromJson(response.body);
  }else{
    throw Exception('FAILED TO LOAD POST');
  }
}