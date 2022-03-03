import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie/controller/fav_db.dart';
import 'package:movie/controller/get_search.dart';

import '../constnts.dart';
import 'desciption_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();

  String vv = "";

  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: minDark,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xff0B0B0D),
              Color(0xff333739),
            ]),
          ),
        ),
        // centerTitle: true,
        title: Text(
          "Search",
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
        elevation: .5,
        backgroundColor: Colors.grey,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white70,
            )),
      ),
      body: Consumer(builder: (context, watch, child) {
        final viewmodelSearch = watch;

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * .05),
              child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * .06,
                  decoration: BoxDecoration(
                      color: light, borderRadius: BorderRadius.circular(7)),
                  child: TextFormField(
                    onChanged: (value) {
                      viewmodelSearch.watch(getSearchData).getData(vv: value);
                      value == ""
                          ? viewmodelSearch
                              .watch(getSearchData)
                              .listDataModel
                              .clear()
                          : null;
                      // vv = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Search is Empty";
                      }
                    },
                    cursorColor: Color(0xFF000000),
                    keyboardType: TextInputType.text,
                    controller: viewmodelSearch
                        .watch(getSearchData)
                        .searchTextController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0xFF000000).withOpacity(0.5),
                        ),
                        suffixIcon: viewmodelSearch
                                .watch(getSearchData)
                                .searchTextController
                                .text
                                .isNotEmpty
                            ? IconButton(
                                icon: Icon(
                                  Icons.close_rounded,
                                  color: dark,
                                ),
                                onPressed: () {
                                  viewmodelSearch
                                      .watch(getSearchData)
                                      .clearSearch();
                                },
                              )
                            : null,
                        hintText: "Search",
                        border: InputBorder.none),
                  )),
            ),
            viewmodelSearch.watch(getSearchData).listDataModel.isEmpty
                ?   SizedBox(
                    child: Center(
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          SizedBox(height: hight*.3,),
                          Text(
                            "Enter the name  of the movie",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: light),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    child: Expanded(
                        child: StaggeredGridView.countBuilder(
                            physics: BouncingScrollPhysics(),
                            crossAxisCount: 2,
                            itemCount: viewmodelSearch
                                .watch(getSearchData)
                                .listDataModel
                                .length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                      builder: (_) => DescScreen(
                                            original_title:
                                                "${viewmodelSearch.watch(getSearchData).listDataModel[index].original_title}",
                                            backdrop_path:
                                                "${image_url+viewmodelSearch.watch(getSearchData).listDataModel[index].backdrop_path}",
                                            release_date:
                                                "${viewmodelSearch.watch(getSearchData).listDataModel[index].release_date}",
                                            id: viewmodelSearch
                                                .watch(getSearchData)
                                                .listDataModel[index]
                                                .id,
                                            poster_path:
                                                "${image_url+viewmodelSearch.watch(getSearchData).listDataModel[index].poster_path}",
                                            title:
                                                "${viewmodelSearch.watch(getSearchData).listDataModel[index].title}",
                                            vote_average: viewmodelSearch
                                                .watch(getSearchData)
                                                .listDataModel[index]
                                                .vote_average,
                                            overview:
                                                "${viewmodelSearch.watch(getSearchData).listDataModel[index].overview}",
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
                                         children: [ Image.network(
                                           image_url +
                                               viewmodelSearch
                                                   .watch(getSearchData)
                                                   .listDataModel[index]
                                                   .poster_path ==
                                               image_url
                                               ? "https://previews.123rf.com/images/kaymosk/kaymosk1804/kaymosk180400005/99776312-fehler-404-seite-nicht-gefunden-fehler-mit-glitch-effekt-auf-dem-bildschirm-vektor-illustration-f%C3%BCr-.jpg"
                                               : image_url +
                                               viewmodelSearch
                                                   .watch(getSearchData)
                                                   .listDataModel[index]
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
                                                           viewmodelSearch
                                                               .watch(
                                                               getSearchData)
                                                               .listDataModel[
                                                           index]
                                                               .id)) {
                                                         favoriteHelper
                                                             .watch(fav)
                                                             .manageFav(
                                                             productId: viewmodelSearch
                                                                 .watch(
                                                                 getSearchData)
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
                                                           'id': viewmodelSearch
                                                               .watch(
                                                               getSearchData)
                                                               .listDataModel[
                                                           index]
                                                               .id,
                                                           'vote_average': viewmodelSearch
                                                               .watch(
                                                               getSearchData)
                                                               .listDataModel[
                                                           index]
                                                               .vote_average,
                                                           'title': viewmodelSearch
                                                               .watch(
                                                               getSearchData)
                                                               .listDataModel[
                                                           index]
                                                               .title,
                                                           'original_title':
                                                           viewmodelSearch
                                                               .watch(
                                                               getSearchData)
                                                               .listDataModel[
                                                           index]
                                                               .original_title,
                                                           'poster_path': viewmodelSearch
                                                               .watch(
                                                               getSearchData)
                                                               .listDataModel[
                                                           index]
                                                               .poster_path,
                                                           'release_date': viewmodelSearch
                                                               .watch(
                                                               getSearchData)
                                                               .listDataModel[
                                                           index]
                                                               .release_date,
                                                           'backdrop_path':
                                                           viewmodelSearch
                                                               .watch(
                                                               getSearchData)
                                                               .listDataModel[
                                                           index]
                                                               .backdrop_path,
                                                           'overview': viewmodelSearch
                                                               .watch(
                                                               getSearchData)
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
                                                         .isFavorite(viewmodelSearch
                                                         .watch(
                                                         getSearchData)
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
                                            viewmodelSearch
                                                .watch(getSearchData)
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
                                StaggeredTile.fit(1))))
          ],
        );
      }),
    );
  }
}
