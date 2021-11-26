import 'package:beamer/beamer.dart';
import 'package:movie_db/page/movie_detailpage.dart';
import 'package:movie_db/page/bookmark.dart';
import 'package:movie_db/page/home.dart';
import 'package:flutter/material.dart';
import 'package:movie_db/page/navigation_page.dart';
import 'package:movie_db/page/nested_page.dart';
import 'package:movie_db/page/not_found.dart';
import 'package:qlevar_router/qlevar_router.dart';

abstract class AppScreen {}

class HomeScreen extends AppScreen {}

class SettingScreen extends AppScreen {}

class BookmarkScreen extends AppScreen {}

class NavigationLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: ValueKey(state.uri.path),
        // type: BeamPageType.fadeTransition,
        child: NavigationPage(),
      ),
    ];
  }

  @override
  List get pathBlueprints => ["/home", "/bookmarks"];
}

class HomeLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        title: "Home",
        key: const ValueKey("/home"),
        type: BeamPageType.fadeTransition,
        child: HomePage(),
      ),
    ];
  }

  @override
  List get pathBlueprints => ["/home"];
}

class BookmarksLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        title: "Bookmarks",
        key: const ValueKey("/bookmarks"),
        type: BeamPageType.fadeTransition,
        child: const BookmarksPage(),
      ),
    ];
  }

  @override
  List get pathBlueprints => ["/bookmarks/:id"];
}

class BookDetailLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      if (state.uri.pathSegments.length == 2)
        BeamPage(
          title: "Movie Detail",
          key: ValueKey("bookdetail-${state.uri.pathSegments[1]}"),
          type: BeamPageType.material,
          child: MovieDetailPage(
            id: state.uri.pathSegments[1],
            appTitle: "Movie Detail",
          ),
        )
      else
        BeamPage(
          title: "404 Not Found",
          key: const ValueKey("/notfound"),
          type: BeamPageType.material,
          child: const NotFoundPage(),
        )
    ];
  }

  @override
  List get pathBlueprints => ["/bookdetail/:id"];
}

class AppRoutes {
  static String indexPage = 'Index Page';
  static String mainPage = 'Main Page';
  static String homePage = 'Home Page';
  static String listPage = 'Bookmarks Page';
  final routes = [
    QRoute(
      pageType: const QFadePage(
        withType: QFadePage(), // set the type to mix with
      ),
      name: indexPage,
      path: '/',
      builder: () => const Center(),
      middleware: [
        QMiddlewareBuilder(redirectGuardFunc: (path) async => "/main")
      ],
    ),
    QRoute(
      path: "movie/:id",
      builder: () => MovieDetailPage(
        appTitle: "",
        id: QR.params['id'].toString(),
      ),
    ),
    QRoute.withChild(
        name: mainPage,
        path: "/main",
        builderChild: (r) => NestedPage(router: r),
        initRoute: '/home',
        pageType: const QFadePage(
          withType: QFadePage(), // set the type to mix with
        ),
        children: [
          QRoute(
            name: homePage,
            path: "/home",
            builder: () => const HomePage(),
            pageType: const QFadePage(
              withType: QFadePage(), // set the type to mix with
            ),
          ),
          QRoute(
            name: listPage,
            path: "/bookmarks",
            builder: () => const BookmarksPage(),
            pageType: const QFadePage(
              withType: QFadePage(), // set the type to mix with
            ),
          )
        ])
  ];
}
