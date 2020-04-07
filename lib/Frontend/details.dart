import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_db/Backend/src/blocs/movies_bloc.dart';
import 'package:movie_db/Backend/src/models/details_api.dart';

class Details extends StatefulWidget {
  final int index;
  final id;
  Details(this.index, this.id);
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
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
              return SpinKitCubeGrid(
                color: Colors.grey,
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(
                child: SpinKitCubeGrid(
              color: Colors.black,
            ));
          },
        ),
      ),
    );
  }
}
