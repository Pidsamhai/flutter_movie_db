import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:movie_db/custom_appbar_for_web.dart';
import 'package:movie_db/router/route.dart';

class NavigationPage extends StatelessWidget {
  NavigationPage({ Key? key }) : super(key: key);

   final _routerDelegate = BeamerDelegate(
    initialPath: '/home',
    locationBuilder: SimpleLocationBuilder(
      routes: {
        '*': (context, state) {
          final beamerKey = GlobalKey<BeamerState>();
          return Scaffold(
            appBar: AppBar(title: const Text("Appbar")),
            body: Beamer(
              key: beamerKey,
              routerDelegate: BeamerDelegate(
                locationBuilder: BeamerLocationBuilder(
                  beamLocations: [
                    HomeLocation(),
                    BookmarksLocation(),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: CustomBottomAppBar(
              beamerKey: beamerKey,
              allowPath: const ["home", "bookmarks"],
            ),
          );
        }
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: BeamerParser(),
      routerDelegate: _routerDelegate,
    );
  }
}