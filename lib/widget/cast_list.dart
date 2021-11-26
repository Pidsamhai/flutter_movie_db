import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_db/api/response/movie_credits.dart';
import 'package:movie_db/cubit/base_state.dart';
import 'package:movie_db/cubit/basic_state.dart';
import 'package:movie_db/cubit/movie_credits_cubit.dart';
import 'package:movie_db/utils/configurations.dart';
import 'package:movie_db/utils/extensions.dart';
import 'package:movie_db/widget/image_broken.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';
import 'package:provider/provider.dart';

class CastList extends StatefulWidget {
  final String movieTvId;
  const CastList({Key? key, required this.movieTvId}) : super(key: key);

  @override
  State<CastList> createState() => _CastListState();
}

class _CastListState extends State<CastList> {
  @override
  void initState() {
    super.initState();
    context.read<MovieCreditsCubit>().init(widget.movieTvId);
  }

  @override
  Widget build(BuildContext context) {
    return SealedBlocBuilder4<
        MovieCreditsCubit,
        BasicState<MovieCredits>,
        Initial,
        Loading,
        Success<MovieCredits>,
        Failure>(builder: (ctx, state) {
      return state(
        (initial) => const SizedBox(height: 300),
        (loading) => const SizedBox(
          height: 300,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        (success) {
          var cast = success.result.cast;
          return SizedBox(
            height: 200,
            width: double.maxFinite,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cast.length,
              itemBuilder: (ctx, index) => Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 150,
                        child: AspectRatio(
                          aspectRatio: 9 / 14,
                          child: CachedNetworkImage(
                            height: 150,
                            errorWidget: (ctx, url, err) =>
                                const ImageBrokenWidget(),
                            imageUrl: cast[index].profilePath
                                    ?.toImgUrl() ??
                                "",
                                fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Deviders.m,
                      Text(cast[index].name ?? "")
                    ],
                  ),
                ),
            ),
          );
        },
        (failure) => Text('Failure: ${failure.error}'),
      );
    });
  }
}
