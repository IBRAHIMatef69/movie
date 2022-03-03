import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 import 'package:movie/model/movie.dart';
import 'package:http/http.dart' as http;

final getData =
    ChangeNotifierProvider<GetDataFromApi>((ref) => GetDataFromApi());

class GetDataFromApi extends ChangeNotifier {
  List<Movie> listDataModel = [];

  var isLoading = true;

  GetDataFromApi() {
    getData();
  }

  Future getData() async {
    listDataModel = [];
    listDataModel.clear();
    try {
      String apiKey = "e304808cb17a2b16cdbb66a01589d260";
      var url = Uri.parse(
          "https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey");
      var response = await http.get(url);
      var responsebody = jsonDecode(response.body)["results"];
      for (int i = 0; i < responsebody.length; i++) {
        listDataModel.add(Movie.fromMap(responsebody[i]));
      }
      isLoading = true;
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }


}
