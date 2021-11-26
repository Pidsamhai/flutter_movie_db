import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final String text;
  const RatingWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.yellow.shade400),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.star,
              color: Colors.yellow.shade400,
              size: Theme.of(context).textTheme.bodyText1?.fontSize ?? 16,
            ),
            Text(text, style: Theme.of(context).textTheme.bodyText1)
          ],
        ),
      ),
    );
  }
}
