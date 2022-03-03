import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/constnts.dart';
import 'package:movie/controller/fav_db.dart';
import 'package:movie/controller/get_bopular.dart';

import 'desciption_screen.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.5,
        title: Text(
          "Favorites",
          style: TextStyle(
            fontSize: 25,
            color: white1,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: dark,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: white1,
        ),
        // centerTitle: true,
      ),
      backgroundColor: minDark,
      body: Consumer(builder: (context, watch, child) {
        final favorit = watch;

        if (favorit.watch(fav).favList.isEmpty

            // controller.favoriteList.isEmpty
            ) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  // child: Image.asset(
                  //   "assets/images/heart.png",
                  //   color: mmainColor,
                  // ),
                  child: Icon(
                    Icons.favorite_outline_rounded,
                    color: Colors.grey[400],
                    size: MediaQuery.of(context).size.width * .7,
                  ),
                ),
                Text(
                  "You Don't have favorites",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          );
        } else {
          return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return BuildFavItems(context,
                    image: image_url +
                        favorit.watch(fav).favList[index].poster_path,
                    date: "${favorit.watch(fav).favList[index].release_date}",
                    title: "${favorit.watch(fav).favList[index].title}",
                    id: favorit.watch(fav).favList[index].id,
                    overview: "${favorit.watch(fav).favList[index].overview}",
                    backdrop_path:
                        "${favorit.watch(fav).favList[index].backdrop_path}",
                    original_title:
                        "${favorit.watch(fav).favList[index].original_title}",
                    vote_average:
                        favorit.watch(fav).favList[index].vote_average);
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.black,
                  thickness: .2,
                  endIndent: 12,
                  indent: 12,
                );
              },
              itemCount: favorit.watch(fav).favList.length);
        }
      }),
    );
  }

  Widget BuildFavItems(
    BuildContext context, {
    required String image,
    required String backdrop_path,
    required num vote_average,
    required String original_title,
    required String title,
    required String overview,
    required String date,
    required int id,
  }) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Consumer(builder: (context, watch, child) {
      final favorit = watch;
      return Padding(
        padding: EdgeInsets.all(8.0),
        child: SizedBox(
            width: double.infinity,
            height: height * .15,
            child: InkWell(onTap: (){   Navigator.of(context).push(CupertinoPageRoute(
                builder: (_) => DescScreen(
                  original_title: "${original_title}",
                  backdrop_path: "${image_url + backdrop_path}",
                  release_date: "${date}",
                  id: id,
                  poster_path: "${image_url + image}",
                  title: "${title}",
                  vote_average: vote_average,
                  overview: "${overview}",
                )));},
              child: Row(
                children: [
                  SizedBox(
                    child: Card(
                      elevation: 2,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.network(
                          "$image",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: width * .06,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: white0,
                              ),
                            ),
                            // SizedBox(
                            // height:25,
                            // ),
                            Text(
                              date,
                              style: TextStyle(
                                // overflow: TextOverflow.ellipsis,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: white1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        // controller.manageFavorite(productId);
                        // favorit.watch(getPopularData).manageFavorite(Id);
                        favorit.watch(fav).manageFav(productId: id);

                      },
                      icon: Icon(
                        Icons.favorite,
                        color: red,
                      ))
                ],
              ),
            )),
      );
    });
  }
}
