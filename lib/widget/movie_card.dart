import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_db/api/response/poplar_tv.dart';
import 'package:movie_db/api/response/upcoming_response.dart';
import 'package:movie_db/utils/extensions.dart';
import 'package:movie_db/widget/rating.dart';

class MovieCard extends BaseMovieTvCard {
  final Function? onTab;
  final Movie movie;
  MovieCard({Key? key, required this.movie, this.onTab})
      : super(
            key: key,
            posterPath: movie.posterPath ?? "",
            title: movie.title ?? "",
            voteAverage: movie.voteAverage ?? 0,
            onTab: onTab);
}

class TvCard extends BaseMovieTvCard {
  final Function? onTab;
  final Tv tv;
  TvCard({Key? key, this.onTab, required this.tv})
      : super(
          key: key,
          posterPath: tv.posterPath ?? "",
          title: tv.name ?? "",
          voteAverage: tv.voteAverage ?? 0,
          onTab: onTab,
        );
}

class BaseMovieTvCard extends StatelessWidget {
  final String posterPath;
  final String title;
  final double voteAverage;
  final Function? onTab;
  const BaseMovieTvCard({
    Key? key,
    this.onTab,
    required this.posterPath,
    required this.title,
    required this.voteAverage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () => onTab?.call(),
        onHover: (b) => {},
        child: Transform.scale(
          scale: 1,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: AspectRatio(
                  aspectRatio: 4 / 5.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: posterPath.toImgUrl(),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RatingWidget(text: voteAverage.toString()),
                    const SizedBox(height: 8),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headline6,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
