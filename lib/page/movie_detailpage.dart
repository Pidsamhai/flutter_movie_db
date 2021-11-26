import 'package:beamer/beamer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_db/api/response/movie_detail.dart';
import 'package:movie_db/cubit/base_state.dart';
import 'package:movie_db/cubit/basic_state.dart';
import 'package:movie_db/cubit/movie_detail_cubit.dart';
import 'package:movie_db/utils/configurations.dart';
import 'package:movie_db/utils/extensions.dart';
import 'package:movie_db/widget/cast_list.dart';
import 'package:movie_db/widget/genres_item.dart';
import 'package:provider/provider.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MovieDetailPage extends StatelessWidget {
  final String id;
  final String appTitle;
  const MovieDetailPage({
    Key? key,
    required this.id,
    required this.appTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<MovieDetailCubit>();
    bloc.init(id);
    return Scaffold(
      appBar: kIsWeb
          ? null
          : AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => QR.back(),
              ),
              title: Text(appTitle),
            ),
      body: SealedBlocBuilder4<MovieDetailCubit, BasicState<MovieDetail>,
          Initial, Loading, Success<MovieDetail>, Failure>(
        bloc: bloc,
        builder: (context, state) => state(
          (initial) => const Text('Initial'),
          (loading) => const Center(child: CircularProgressIndicator()),
          (success) => buildContent(context, success.result),
          (failure) => Text('Failure: ${failure.error}'),
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context, MovieDetail movieDetail) {
    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: movieDetail.title ?? appTitle,
      primaryColor: Theme.of(context).primaryColor.value,
    ));
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          MovieDetailCover(movieDetail),
          ResponsiveRowColumn(
            columnMainAxisSize: MainAxisSize.max,
            rowMainAxisSize: MainAxisSize.max,
            // layout: (context.responsive.isMobile)
            //     ? ResponsiveRowColumnType.COLUMN
            //     : ResponsiveRowColumnType.ROW,
            layout: (context.responsive.isSmallerThan(MOBILE))
                ? ResponsiveRowColumnType.COLUMN
                : ResponsiveRowColumnType.ROW,
            children: [
              ResponsiveRowColumnItem(
                rowFlex: 2,
                rowFit: FlexFit.tight,
                child: Column(
                  children: [
                    _buildMovieDescription(movieDetail),
                    ResponsiveVisibility(
                      visible: !context.responsive.isMobile,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(movieDetail.overview ?? ""),
                      ),
                    ),
                    // ResponsiveVisibility(
                    //   visible: !context.responsive.isMobile,
                    //   child: Container(height: 300,width: 300,color: Colors.red, child: CastList(movieTvId: id,),),
                    // )
                    // // CastList(movieTvId: id)
                  ],
                ),
              ),
              ResponsiveRowColumnItem(
                // rowFlex: 1,
                rowFit: FlexFit.tight,
                child: ResponsiveVisibility(
                  visible: context.responsive.isMobile,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(movieDetail.overview ?? ""),
                        
                      ],
                    ),
                  ),
                ),
              ),
              // ResponsiveRowColumnItem(
              //   // rowFlex: 1,
              //   rowFit: FlexFit.tight,
              //   child: Container(
              //     height: 300,
              //     color: Colors.green,
              //   ),
              // ),
              ResponsiveRowColumnItem(
                // rowFlex: 1,
                rowFit: FlexFit.tight,
                child:
                    _buildProductionCompanies(movieDetail.productionCompanies),
              ),
            ],
          ),
          // Container(
          //   height: 200,
          //   child: ,
          // )
          CastList(movieTvId: id)
        ],
      ),
    );
  }

  Widget _buildMovieDescription(MovieDetail movieDetail) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPosterImage(movieDetail),
          Deviders.m,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(movieDetail.title ?? ""),
                if (movieDetail.title != movieDetail.originalTitle)
                  Text(movieDetail.originalTitle ?? ""),
                Deviders.m,
                Wrap(
                  direction: Axis.horizontal,
                  runSpacing: 8,
                  spacing: 8,
                  children: movieDetail.genres
                      .map((e) => GenreItem(genre: e!))
                      .toList(),
                ),
                Deviders.m,
                SizedBox(
                  width: 200,
                  height: 60,
                  child: ElevatedButton.icon(
                    onPressed: () => {},
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: const Text("WATCH"),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPosterImage(MovieDetail movieDetail) {
    return SizedBox(
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: AspectRatio(
          aspectRatio: 9 / 16,
          child: CachedNetworkImage(
              imageUrl: movieDetail.posterPath?.toImgUrlOriginal() ?? "",
              fit: BoxFit.fill,
              height: 200),
        ),
      ),
    );
  }

  Widget _buildProductionCompanies(List<ProductionCompanies?> items) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: double.maxFinite,
      child: Wrap(
        runSpacing: 8,
        spacing: 8,
        direction: Axis.vertical,
        runAlignment: WrapAlignment.end,
        children: items
            .map(
              (e) => CachedNetworkImage(
                imageUrl: e!.logoPath?.toImgUrlOriginal() ?? "",
                height: 50,
                errorWidget: (context, url, error) => Center(
                  child: Text(
                    e.name ?? "",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class MovieDetailCover extends StatelessWidget {
  final MovieDetail _movieDetail;
  const MovieDetailCover(
    this._movieDetail, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width > 600 ? 500 : 300,
          width: double.maxFinite,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
            child: CachedNetworkImage(
              imageUrl: _movieDetail.backdropPath?.toImgUrlOriginal() ?? "",
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: const Color(0xFFEEEEEE),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              alignment: Alignment.topCenter,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                height: 50,
                width: 50,
                child: SfRadialGauge(
                  axes: <RadialAxis>[
                    RadialAxis(
                      interval: 10,
                      radiusFactor: 0.95,
                      startAngle: 270,
                      endAngle: 270,
                      showTicks: false,
                      showLabels: false,
                      axisLineStyle:
                          const AxisLineStyle(color: Colors.transparent),
                      pointers: <GaugePointer>[
                        RangePointer(
                          value: _movieDetail.voteAverage != null
                              ? _movieDetail.voteAverage! * 10
                              : 0,
                          width: 4,
                          color: Colors.red,
                          enableAnimation: true,
                          gradient: const SweepGradient(colors: <Color>[
                            Colors.yellow,
                            // Colors.green,
                          ]),
                          cornerStyle: CornerStyle.bothCurve,
                        )
                      ],
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                          widget: Center(
                            child: SizedBox(
                              child: Text(
                                '${_movieDetail.voteAverage}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.yellow),
                              ),
                            ),
                          ),
                          // angle: 270,
                          positionFactor: 0.2,
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _movieDetail.voteCount?.toString() ?? "",
                    style: const TextStyle(color: Colors.yellow, fontSize: 16),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
