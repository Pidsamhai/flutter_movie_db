import 'package:flutter/material.dart';
import 'package:movie_db/router/route.dart';
import 'package:qlevar_router/qlevar_router.dart';

class NestedPage extends StatelessWidget {
  final QRouter router;
  const NestedPage({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Appbar"),
      ),
      body: router,
      bottomNavigationBar: CustomBottomAppBar(router: router),
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
