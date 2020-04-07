import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_db/Backend/src/blocs/movies_bloc.dart';
import 'package:movie_db/Backend/src/models/list_api.dart';
import 'package:movie_db/Frontend/details.dart';
import 'package:movie_db/theme.dart';
import 'package:page_transition/page_transition.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  void initState() {
    super.initState();
    bloc.fetchAllMovies();
  }

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return SafeArea(
      top: true,
      child: Material(
        child: Container(
          color: background,
          height: _media.height,
          width: _media.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'THE MOVIE DB',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w300),
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: bloc.allMovies,
                  builder: (context, AsyncSnapshot<MovieModel> snapshot) {
                    if (snapshot.hasData) {
                      return Scrollbar(child: buildList(snapshot));
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    return Center(
                        child: SpinKitCubeGrid(
                      color: Colors.white,
                    ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildList(AsyncSnapshot<MovieModel> snapshot) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GridView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: snapshot.data.results.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 3 / 4.7),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.only(left: 8, right: 8, bottom: 20),
              child: Card(
                color: Colors.transparent,
                elevation: 5,
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            child: FadeInImage.assetNetwork(
                              placeholder: 'Loading',
                              image:
                                  'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].poster_path}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  snapshot.data.results[index].title,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  snapshot.data.results[index].release_date,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                          borderRadius: BorderRadius.circular(5),
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: Details(
                                      index, snapshot.data.results[index].id),
                                ));
                          },
                          child: Expanded(
                            child: Container(
                              color: Colors.transparent,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
