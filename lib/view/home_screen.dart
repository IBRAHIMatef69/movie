import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie/constnts.dart';
import 'package:movie/controller/fav_db.dart';
import 'package:movie/controller/get_bopular.dart';
import 'package:movie/controller/get_data_from_api.dart';
import 'package:movie/view/desciption_screen.dart';
import 'package:movie/view/fav_svreen.dart';
import 'package:movie/view/search_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Note().db;
  }

  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: minDark,
      appBar: AppBar(
        elevation: 1.5,
        title: Text(
          "Egy Dead",
          style: TextStyle(
            fontSize: 25,
            color: white1,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: dark,
        actions: [
          IconButton(
            color: white1,
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => SearchScreen()));
            },
            icon: const Icon(Icons.search),
          ),
          Consumer(builder: (context, watch, child) {
            final viewFav = watch;

            return Badge(
              borderSide: BorderSide(
                color: viewFav.watch(fav).favList.length == 0
                    ? Colors.transparent
                    : white1,
                width: 1,
              ),
              badgeColor: viewFav.watch(fav).favList.length == 0
                  ? Colors.transparent
                  : red,
              elevation: 0,
              position: BadgePosition.topEnd(top: 5, end: 5),
              animationDuration: Duration(milliseconds: 400),
              animationType: BadgeAnimationType.slide,
              badgeContent: viewFav.watch(fav).favList.length == 0
                  ? Text("", style: TextStyle(color: white0))
                  : Text(
                      "${viewFav.watch(fav).favList.length}",
                      style: TextStyle(color: white0, fontSize: 12),
                    ),
              child: IconButton(
                color: white1,
                onPressed: () {
                  Navigator.of(context).push(
                      CupertinoPageRoute(builder: (_) => FavoriteScreen()));
                },
                icon: const Icon(
                  Icons.favorite,
                  color: red,
                ),
              ),
            );
          }),
        ],
        // centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer(
              builder: (context, watch, child) {
                final viewmodeltoprated = watch;

                return viewmodeltoprated.watch(getData).isLoading == true
                    ? SizedBox()
                    : CarouselSlider.builder(
                        itemCount: viewmodeltoprated
                            .watch(getData)
                            .listDataModel
                            .length,
                        itemBuilder: (context, int index, int realIndex) {
                          return Column(
                            children: [
                              Container(
                                height: hight * .20,
                                decoration: BoxDecoration(
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: Colors.grey.withOpacity(0.5),
                                    //     spreadRadius: 2,
                                    //     blurRadius: 6,
                                    //     offset: Offset(
                                    //         0, 3), // changes position of shadow
                                    //   ),
                                    // ],
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          image_url +
                                              viewmodeltoprated
                                                  .watch(getData)
                                                  .listDataModel[index]
                                                  .poster_path,
                                        ),
                                        fit: BoxFit.fill),
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                viewmodeltoprated
                                    .watch(getData)
                                    .listDataModel[index]
                                    .title,
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: white1,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          );
                        },
                        options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 1.7,
                            viewportFraction: .9,
                            height: hight * .29,
                            initialPage: 0,
                            enableInfiniteScroll: false,
                            reverse: false,
                            autoPlayInterval: Duration(seconds: 4),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 700),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal));
              },
            ),
            Consumer(builder: (context, watch, child) {
              final viewmodelpopular = watch;

              return viewmodelpopular.watch(getPopularData).isLoading == true
                  ? Center(
                      child: CircularProgressIndicator(
                      color: light,
                    ))
                  : Container(
                      child: Expanded(
                          child: StaggeredGridView.countBuilder(
                              physics: BouncingScrollPhysics(),
                              crossAxisCount: 2,
                              itemCount: viewmodelpopular
                                  .watch(getPopularData)
                                  .listDataModel
                                  .length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(CupertinoPageRoute(
                                            builder: (_) => DescScreen(
                                                  original_title:
                                                      "${viewmodelpopular.watch(getPopularData).listDataModel[index].original_title}",
                                                  backdrop_path:
                                                      "${image_url + viewmodelpopular.watch(getPopularData).listDataModel[index].backdrop_path}",
                                                  release_date:
                                                      "${viewmodelpopular.watch(getPopularData).listDataModel[index].release_date}",
                                                  id: viewmodelpopular
                                                      .watch(getPopularData)
                                                      .listDataModel[index]
                                                      .id,
                                                  poster_path:
                                                      "${image_url + viewmodelpopular.watch(getPopularData).listDataModel[index].poster_path}",
                                                  title:
                                                      "${viewmodelpopular.watch(getPopularData).listDataModel[index].title}",
                                                  vote_average: viewmodelpopular
                                                      .watch(getPopularData)
                                                      .listDataModel[index]
                                                      .vote_average,
                                                  overview:
                                                      "${viewmodelpopular.watch(getPopularData).listDataModel[index].overview}",
                                                )));
                                  },
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      color: black0,
                                      child: Column(
                                        children: [
                                          Stack(
                                            children: [
                                              Image.network(
                                                image_url +
                                                            viewmodelpopular
                                                                .watch(
                                                                    getPopularData)
                                                                .listDataModel[
                                                                    index]
                                                                .poster_path ==
                                                        image_url
                                                    ? "https://previews.123rf.com/images/kaymosk/kaymosk1804/kaymosk180400005/99776312-fehler-404-seite-nicht-gefunden-fehler-mit-glitch-effekt-auf-dem-bildschirm-vektor-illustration-f%C3%BCr-.jpg"
                                                    : image_url +
                                                        viewmodelpopular
                                                            .watch(
                                                                getPopularData)
                                                            .listDataModel[
                                                                index]
                                                            .poster_path,
                                                fit: BoxFit.fill,
                                              ),
                                              Positioned(
                                                right: 5,
                                                top: 5,
                                                child: Card(
                                                  elevation: 2,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: CircleAvatar(
                                                    radius: 17,
                                                    child: Consumer(builder:
                                                        (context, watch,
                                                            child) {
                                                      final favoriteHelper =
                                                          watch;
                                                      return IconButton(
                                                        onPressed: () {
                                                          if (favoriteHelper
                                                              .watch(fav)
                                                              .favList
                                                              .any((element) =>
                                                                  element.id ==
                                                                  viewmodelpopular
                                                                      .watch(
                                                                          getPopularData)
                                                                      .listDataModel[
                                                                          index]
                                                                      .id)) {
                                                            favoriteHelper
                                                                .watch(fav)
                                                                .manageFav(
                                                                    productId: viewmodelpopular
                                                                        .watch(
                                                                            getPopularData)
                                                                        .listDataModel[
                                                                            index]
                                                                        .id);

                                                            ///////////////////////////////
                                                            // favoriteHelper
                                                            //     .watch(fav)
                                                            //     .deletedb(viewmodelpopular
                                                            //         .watch(
                                                            //             getPopularData)
                                                            //         .listDataModel[
                                                            //             index]
                                                            //         .id);
                                                            // favoriteHelper
                                                            //     .watch(fav)
                                                            //     .chickFav(viewmodelpopular
                                                            //         .watch(
                                                            //             getPopularData)
                                                            //         .listDataModel[
                                                            //             index]
                                                            //         .id);
                                                            // favoriteHelper
                                                            //     .watch(fav)
                                                            //     .getdb();
                                                            // print(favoriteHelper
                                                            //     .watch(fav)
                                                            //     .favList.length);
                                                          } else {
                                                            favoriteHelper
                                                                .watch(fav)
                                                                .insertdb({
                                                              'id': viewmodelpopular
                                                                  .watch(
                                                                      getPopularData)
                                                                  .listDataModel[
                                                                      index]
                                                                  .id,
                                                              'vote_average': viewmodelpopular
                                                                  .watch(
                                                                      getPopularData)
                                                                  .listDataModel[
                                                                      index]
                                                                  .vote_average,
                                                              'title': viewmodelpopular
                                                                  .watch(
                                                                      getPopularData)
                                                                  .listDataModel[
                                                                      index]
                                                                  .title,
                                                              'original_title':
                                                                  viewmodelpopular
                                                                      .watch(
                                                                          getPopularData)
                                                                      .listDataModel[
                                                                          index]
                                                                      .original_title,
                                                              'poster_path': viewmodelpopular
                                                                  .watch(
                                                                      getPopularData)
                                                                  .listDataModel[
                                                                      index]
                                                                  .poster_path,
                                                              'release_date': viewmodelpopular
                                                                  .watch(
                                                                      getPopularData)
                                                                  .listDataModel[
                                                                      index]
                                                                  .release_date,
                                                              'backdrop_path':
                                                                  viewmodelpopular
                                                                      .watch(
                                                                          getPopularData)
                                                                      .listDataModel[
                                                                          index]
                                                                      .backdrop_path,
                                                              'overview': viewmodelpopular
                                                                  .watch(
                                                                      getPopularData)
                                                                  .listDataModel[
                                                                      index]
                                                                  .overview,
                                                            });

                                                            // favoriteHelper
                                                            //     .watch(fav)
                                                            //     .getdb();
                                                          }
                                                        },
                                                        icon: favoriteHelper
                                                                .watch(fav)
                                                                .isFavorite(viewmodelpopular
                                                                    .watch(
                                                                        getPopularData)
                                                                    .listDataModel[
                                                                        index]
                                                                    .id)
                                                            ? Icon(
                                                                Icons.favorite,
                                                                size: 18,
                                                                color: red,
                                                              )
                                                            : Icon(
                                                                Icons
                                                                    .favorite_border,
                                                                size: 18,
                                                                color: red,
                                                              ),
                                                      );
                                                    }),
                                                    backgroundColor: light,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              viewmodelpopular
                                                  .watch(getPopularData)
                                                  .listDataModel[index]
                                                  .title,
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                  color: light),
                                            ),
                                          )
                                        ],
                                      )),
                                );
                              },
                              staggeredTileBuilder: (int index) =>
                                  StaggeredTile.fit(1))));
            })
          ],
        ),
      ),
    );
  }
}
