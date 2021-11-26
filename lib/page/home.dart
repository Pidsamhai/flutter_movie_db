import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/api/response/poplar_tv.dart';
import 'package:movie_db/api/response/upcoming_response.dart';
import 'package:movie_db/cubit/base_state.dart';
import 'package:movie_db/cubit/basic_state.dart';
import 'package:movie_db/cubit/popular_tv_cubit.dart';
import 'package:movie_db/cubit/upcoming_cubit.dart';
import 'package:movie_db/utils/configurations.dart';
import 'package:movie_db/widget/movie_card.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Deviders.m,
              SectionMovieTvList<UpcomingCubit, Movie>(
                title: "Upcoming Movie",
                init: (bloc) => bloc.init(),
                itemBuilder: (context, item) => MovieCard(
                  movie: item,
                  onTab: () => QR.to("movie/${item.id}"),
                ),
              ),
              SectionMovieTvList<PopularTvCubit, Tv>(
                title: "Popular Tv",
                init: (bloc) => bloc.init(),
                itemBuilder: (context, item) => TvCard(
                  tv: item,
                  // onTab: () => QR.to("movie/${item.id}"),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class SectionMovieTvList<B extends Cubit<BasicState<List<T>>>, T>
    extends StatefulWidget {
  final Function(B bloc) init;
  final String title;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final VoidCallback? onMoreTab;
  const SectionMovieTvList({
    Key? key,
    required this.itemBuilder,
    required this.init,
    required this.title,
    this.onMoreTab,
  }) : super(key: key);

  @override
  State<SectionMovieTvList<B, T>> createState() =>
      _SectionMovieTvListState<B, T>();
}

class _SectionMovieTvListState<B extends Cubit<BasicState<List<T>>>, T>
    extends State<SectionMovieTvList<B, T>> {
  @override
  void initState() {
    super.initState();
    widget.init(context.read<B>());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextButton(
                onPressed: () => widget.onMoreTab,
                child: Text(
                  "More",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              )
            ],
          ),
        ),
        SealedBlocBuilder4<B, BasicState<List<T>>, Initial, Loading,
            Success<List<T>>, Failure>(
          bloc: context.read(),
          builder: (context, state) {
            return state(
              (initial) => const SizedBox(height: 300),
              (loading) => const SizedBox(
                height: 300,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              (success) {
                var result = success.result;
                var scrollController = ScrollController();
                return SizedBox(
                  height: 300,
                  child: Scrollbar(
                    controller: scrollController,
                    child: ListView.builder(
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: result.length,
                      itemBuilder: (context, index) => SizedBox(
                        height: 200,
                        width: 150,
                        child: widget.itemBuilder(context, result[index]),
                      ),
                    ),
                  ),
                );
              },
              (failure) => Text('Failure: ${failure.error}'),
            );
          },
        ),
      ],
    );
  }
}
