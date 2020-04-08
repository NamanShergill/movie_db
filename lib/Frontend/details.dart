import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_db/Backend/src/blocs/movies_bloc.dart';
import 'package:movie_db/Backend/src/models/details_api.dart';
import 'package:movie_db/theme.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Details extends StatefulWidget {
  final int index;
  final id;
  Details(this.index, this.id);
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Color bg = Colors.white;
  Color line = Colors.redAccent;
  static Icon add = Icon(Icons.add);
  static Icon check = Icon(Icons.check);
  Icon list = add;

  double rating;

  @override
  void initState() {
    super.initState();
    bloc.fetchDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return SafeArea(
      top: true,
      bottom: true,
      child: Material(
        child: StreamBuilder(
          stream: bloc.detailInfo,
          builder: (context, AsyncSnapshot<DetailModel> snapshot) {
            if (snapshot.hasData) {
              rating = snapshot.data.voteAverage.roundToDouble() / 2;
              return Expanded(
                child: Container(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Material(
                                color: Colors.transparent,
                                child: IconButton(
                                  icon: Icon(Icons.keyboard_backspace),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ),
                            Text(
                              'THE MOVIE DB',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w300),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Opacity(
                                opacity: 0,
                                child: Material(
                                  color: Colors.transparent,
                                  child: IconButton(
                                    icon: Icon(Icons.search),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: _media.height / 2.4,
                        child: Stack(
                          children: <Widget>[
                            ClipPath(
                              clipper: CustomClipPath(),
                              child: Container(
                                height: _media.height / 2.4,
                                width: double.infinity,
                                color: Colors.grey.shade200,
                                child: Stack(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Expanded(
                                          child: FadeInImage.assetNetwork(
                                            fadeOutDuration:
                                                Duration(milliseconds: 3000),
                                            placeholder: '',
                                            image:
                                                'https://image.tmdb.org/t/p/w185${snapshot.data.posterPath}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                        child: Container(
                                      color: Colors.black54,
                                    )),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Material(
                                              color: Colors.transparent,
                                              child: IconButton(
                                                icon: list,
                                                onPressed: () {
                                                  setState(() {
                                                    print(list);
                                                    list == add
                                                        ? list = check
                                                        : list = add;
                                                    print(list);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Material(
                                              elevation: 10,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: Colors.transparent,
                                              child: AnimatedContainer(
                                                  duration: Duration(
                                                      milliseconds: 300),
                                                  decoration: BoxDecoration(
                                                    color: bg,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      onTap: () {
                                                        setState(() {
                                                          bg == Colors.redAccent
                                                              ? bg =
                                                                  Colors.white
                                                              : bg = Colors
                                                                  .redAccent;
                                                          line ==
                                                                  Colors
                                                                      .redAccent
                                                              ? line =
                                                                  Colors.white
                                                              : line = Colors
                                                                  .redAccent;
                                                        });
                                                      },
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(20),
                                                        color:
                                                            Colors.transparent,
                                                        child: Icon(
                                                          Icons.favorite_border,
                                                          color: line,
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Material(
                                              color: Colors.transparent,
                                              child: IconButton(
                                                icon: Icon(Icons.share),
                                                onPressed: () {},
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            children: <Widget>[
                              Text(
                                snapshot.data.title.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Center(
                                child: SmoothStarRating(
                                    allowHalfRating: true,
                                    starCount: 5,
                                    rating: rating,
                                    size: 40.0,
                                    halfFilledIconData: Icons.blur_on,
                                    color: Colors.redAccent,
                                    borderColor: Colors.redAccent,
                                    spacing: 0.0),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    width: 100,
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          'Year',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Text(
                                          snapshot.data.releaseDate.year
                                              .toString(),
                                          style: info,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          'Adult',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Text(
                                          snapshot.data.adult
                                              .toString()
                                              .toUpperCase(),
                                          style: info,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          'Runtime',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Text(
                                          snapshot.data.runtime.toString() +
                                              ' Min',
                                          style: info,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  snapshot.data.overview,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 17),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              colorCard(
                                  'Budget',
                                  snapshot.data.budget != 0
                                      ? snapshot.data.budget.toString() + '\$'
                                      : 'N/A',
                                  context)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Container(
              height: _media.height,
              width: _media.width,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Material(
                            color: Colors.transparent,
                            child: IconButton(
                              icon: Icon(Icons.keyboard_backspace),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                        Text(
                          'THE MOVIE DB',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w300),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Opacity(
                            opacity: 0,
                            child: Material(
                              color: Colors.transparent,
                              child: IconButton(
                                icon: Icon(Icons.search),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ClipPath(
                    clipper: CustomClipPath(),
                    child: Container(
                      height: _media.height / 2.4,
                      width: double.infinity,
                      color: Colors.grey.shade200,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SpinKitCubeGrid(
                              color: Colors.grey.shade400,
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade100,
                        highlightColor: Colors.grey.shade200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: SmoothStarRating(
                                  allowHalfRating: true,
                                  starCount: 5,
                                  rating: 5,
                                  size: 40.0,
                                  halfFilledIconData: Icons.blur_on,
                                  color: Colors.redAccent,
                                  borderColor: Colors.redAccent,
                                  spacing: 0.0),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: 5,
                              itemBuilder: (BuildContext context, int index) =>
                                  Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    color: Colors.red,
                                    height: 40,
                                    width: _media.width * 0.7,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 5.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

Widget colorCard(String text, String text2, BuildContext context) {
  final _media = MediaQuery.of(context).size;
  return Container(
    constraints: BoxConstraints(minWidth: 100),
    margin: EdgeInsets.only(left: 10, right: 10),
    decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.redAccent.withOpacity(0.4),
              blurRadius: 3,
              spreadRadius: 0.2,
              offset: Offset(0, 2)),
        ]),
    child: Material(
      borderRadius: BorderRadius.circular(15),
      color: Colors.redAccent,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                text2,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
