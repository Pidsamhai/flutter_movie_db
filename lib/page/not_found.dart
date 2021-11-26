import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "404 Not found",
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }
}
