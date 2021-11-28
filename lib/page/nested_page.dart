import 'package:flutter/material.dart';
import 'package:movie_db/router/route.dart';
import 'package:movie_db/widget/navigation_rail.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:movie_db/utils/extensions.dart';
import 'package:responsive_framework/responsive_framework.dart';

class NestedPage extends StatelessWidget {
  final QRouter router;
  const NestedPage({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedtomContainer(router: router),
      bottomNavigationBar: context.responsive.isSmallerThan(DESKTOP)
          ? CustomBottomAppBar(router: router)
          : null,
    );
  }
}

class NestedtomContainer extends StatefulWidget {
  final QRouter router;
  const NestedtomContainer({Key? key, required this.router})
      : super(key: key);

  @override
  State<NestedtomContainer> createState() => _NestedtomContainerState();
}

class _NestedtomContainerState extends State<NestedtomContainer> {
  int _selected = 0;

  _listener() => setState(() => {});

  @override
  void initState() {
    super.initState();
    widget.router.navigator.addListener(_listener);
  }

  @override
  void dispose() {
    super.dispose();
    widget.router.navigator.removeListener(_listener);
  }

  @override
  Widget build(BuildContext context) {
    _selected = widget.router.routeName == AppRoutes.homePage ? 0 : 1;
    return CustomNavigationRail(
      visible: context.responsive.isLargerThan(TABLET),
      onTab: (index) {
        if (index == 0) {
          QR.toName(AppRoutes.homePage);
        } else {
          QR.toName(AppRoutes.listPage);
        }
      },
      selected: _selected,
      items: [
        CustomNavigationRailItem(
            title: "Home",
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home)),
        CustomNavigationRailItem(
            title: "Bookmarks",
            icon: const Icon(Icons.bookmark_outline),
            selectedIcon: const Icon(Icons.bookmark)),
      ],
      child: widget.router,
    );
  }
}

class CustomBottomAppBar extends StatefulWidget {
  final QRouter router;
  const CustomBottomAppBar({Key? key, required this.router}) : super(key: key);

  @override
  _CustomBottomAppBarState createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  int _selected = 0;

  _listener() => setState(() => {});

  @override
  void initState() {
    super.initState();
    widget.router.navigator.addListener(_listener);
  }

  @override
  void dispose() {
    super.dispose();
    widget.router.navigator.removeListener(_listener);
  }

  @override
  Widget build(BuildContext context) {
    _selected = widget.router.routeName == AppRoutes.homePage ? 0 : 1;
    return BottomNavigationBar(
      currentIndex: _selected,
      onTap: (index) {
        if (index == 0) {
          QR.toName(AppRoutes.homePage);
        } else {
          QR.toName(AppRoutes.listPage);
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting"),
      ],
    );
  }
}
