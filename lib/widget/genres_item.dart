import 'package:flutter/material.dart';
import 'package:movie_db/api/response/movie_detail.dart';

class GenreItem extends StatefulWidget {
  final Genres genre;
  const GenreItem({
    Key? key,
    required this.genre,
  }) : super(key: key);

  @override
  State<GenreItem> createState() => _GenreItemState();
}

class _GenreItemState extends State<GenreItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () => {},
      onHover: (b) => setState(() => _hovered = b),
      child: Container(
        decoration: BoxDecoration(
            color: _hovered
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
                width: 2, color: Theme.of(context).colorScheme.primary)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.genre.name ?? "",
            style: TextStyle(
              color: _hovered
                  ? Colors.white
                  : Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}