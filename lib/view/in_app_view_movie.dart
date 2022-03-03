import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:movie/constnts.dart';

class InAppViewMovie extends StatefulWidget {
  int id;
  num vote_average;
  String title;
  String original_title;
  String poster_path;
  String release_date;
  String backdrop_path;
  String overview;

  @override
  _InAppViewMovieState createState() => _InAppViewMovieState();

  InAppViewMovie({
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

class _InAppViewMovieState extends State<InAppViewMovie> {
  double _progress = 0;
  late InAppWebViewController webView;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await webView.canGoBack()) {
          webView.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () async {
              if (await webView.canGoBack()) {
                webView.goBack();
              } else {
                Navigator.pop(context);
              }
            },
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: white0,
            ),
          ),
          actions: [
            // IconButton(
            //     onPressed: () async {
            //       if (await webView.canGoBack()) {
            //         webView.goBack();
            //       }
            //     },
            //     icon: Icon(
            //       Icons.arrow_back_rounded,
            //       color: white0,
            //     )),
            IconButton(
                onPressed: () async {
                  await webView.reload();
                },
                icon: Icon(
                  Icons.refresh,
                  color: white0,
                )),
          ],
        ),
        body: SafeArea(
          child: Stack(
            children: [
              InAppWebView(
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    allowUniversalAccessFromFileURLs: true,
                    javaScriptEnabled: true,
                    mediaPlaybackRequiresUserGesture: true,
                  ),
                ),
                initialUrlRequest: URLRequest(
                    url: Uri.parse(
                        "https://w1.egydead.live/?s=${widget.title}")),
                onWebViewCreated: (InAppWebViewController controller) {
                  webView = controller;
                },
                onProgressChanged:
                    (InAppWebViewController controller, int progress) {
                  setState(() {
                    _progress = progress / 100;
                  });
                }, // URLRequest
              ),
              _progress < 1
                  ? SizedBox(
                      child: Center(
                        child: CircularProgressIndicator(
                          value: _progress,
                          backgroundColor: white0,
                        ),
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
