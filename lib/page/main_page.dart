import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:movie_db/router/route.dart';
import 'package:movie_db/utils/configurations.dart';
import 'package:movie_db/custom_appbar_for_web.dart';

class MainPage extends StatelessWidget {
  final _beamerKey = GlobalKey<BeamerState>();
  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isShowWebMenu
          ? AppBar(
              flexibleSpace: CustomAppBar(
                beamerKey: _beamerKey,
              ),
            )
          : null,
      body: Beamer(
        key: _beamerKey,
        routerDelegate: BeamerDelegate(
          locationBuilder: BeamerLocationBuilder(
            beamLocations: [
              HomeLocation(),
              BookmarksLocation(),
              BookDetailLocation()
            ],
          ),
        ),
      ),
      bottomNavigationBar: isShowBottomMenu
          ? CustomBottomAppBar(
              beamerKey: _beamerKey,
              allowPath: const ["home", "bookmarks"],
            )
          : null,
    );
  }
}
