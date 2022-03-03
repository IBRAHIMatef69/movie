import 'package:draggable_fab/draggable_fab.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/view/in_app_view_movie.dart';
import 'package:readmore/readmore.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

import '../constnts.dart';

class DescScreen extends StatefulWidget {
  int id;
  num vote_average;
  String title;
  String original_title;
  String poster_path;
  String release_date;
  String backdrop_path;
  String overview;

  @override
  State<DescScreen> createState() => _DescScreenState();

  DescScreen({
    required this.id,
    required this.vote_average,
    required this.title,
    required this.original_title,
    required this.poster_path,
    required this.release_date,
    required this.backdrop_path,
    required this.overview,
  });
}

class _DescScreenState extends State<DescScreen> {
  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: Image.network(
              widget.poster_path,
              fit: BoxFit.fill,
            ),
          ),
          BackdropFilter(
            filter: ui.ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: Container(
              color: black2.withOpacity(.7),
            ),
          ),
          Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios, color: white0),
                ),
                backgroundColor: Colors.transparent,
                title: Text(
                  "Back",
                  style: TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold, color: white0),
                ),
                elevation: 0,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    // SizedBox(
                    //   height: hight * .04,
                    // ),
                    // Container(
                    //   alignment: Alignment.topLeft,
                    //   child: TextButton.icon(
                    //       onPressed: () {
                    //         Navigator.pop(context);
                    //       },
                    //       icon: Icon(
                    //         Icons.arrow_back_ios,
                    //         color: white0,
                    //       ),
                    //       label: Text(
                    //         "Back",
                    //         style: TextStyle(
                    //             color: white0,
                    //             fontSize: 22,
                    //             fontWeight: FontWeight.bold),
                    //       )),
                    // ),
                    SizedBox(
                      height: hight * .04,
                    ),
                    FlipCard(
                      front: Container(
                          padding: EdgeInsets.symmetric(horizontal: 3),
                          height: hight / 1.6,
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              color: dark,
                              elevation: 3,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(widget.poster_path),
                              ))),
                      // Container(
                      //   height: hight / 1.6,
                      //   width: width,
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(10),
                      //       image: DecorationImage(
                      //           image: NetworkImage(widget.poster_path))),
                      // ),
                      fill: Fill.fillBack,
                      direction: FlipDirection.HORIZONTAL,
                      back: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(widget.backdrop_path),
                      ),
                    ),
                    SizedBox(
                      height: hight * .01,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 70,
                            child: Text(
                              widget.title,
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: white0),
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            flex: 30,
                            child: Text(
                              "${widget.vote_average}/10",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: widget.vote_average>=7.5? Color(0xffFFF323): white0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.release_date,
                          style: TextStyle(
                            fontSize: 16, height: 1.5,
                            fontWeight: FontWeight.w700,
                            color: white1,
                            // TextStyle
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      child: ReadMoreText(
                        widget.overview,
                        trimLines: 3,
                        trimMode: TrimMode.Line,

                        textAlign: TextAlign.justify,
                        trimCollapsedText: " Show More",
                        trimExpandedText: " Show Less",
                        lessStyle: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: white0,
                        ),
                        // TextStyle
                        moreStyle: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: white0,
                        ),
                        // TextStyle
                        style: TextStyle(
                          fontSize: 16, height: 1.5,
                          fontWeight: FontWeight.w700,
                          color: white1,
                          // TextStyle
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 75,
                    )
                  ],
                ),
              ),
              floatingActionButton: DraggableFab(
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (_) => InAppViewMovie(
                              backdrop_path: widget.backdrop_path,
                              release_date: widget.release_date,
                              title: widget.title,
                              poster_path: widget.poster_path,
                              overview: widget.overview,
                              original_title: widget.original_title,
                              id: widget.id,
                              vote_average: widget.vote_average,
                            )));
                  },
                  child: Icon(
                    Icons.play_arrow_rounded,
                    size: 40,
                    color: red,
                  ),
                  splashColor: red.withOpacity(.2),
                  backgroundColor: light,
                ),
              )),
        ],
      ),
    );
  }
}
