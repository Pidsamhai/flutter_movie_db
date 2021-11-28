import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_db/api/response/upcoming_response.dart';
import 'package:movie_db/cubit/base_state.dart';
import 'package:movie_db/cubit/basic_state.dart';
import 'package:movie_db/cubit/upcoming_cubit.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';
import 'package:movie_db/utils/extensions.dart';

class UpcomingCarouselWidget extends StatefulWidget {
  const UpcomingCarouselWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<UpcomingCarouselWidget> createState() => _UpcomingCarouselWidgetState();
}

class _UpcomingCarouselWidgetState extends State<UpcomingCarouselWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: SealedBlocBuilder4<UpcomingCubit, BasicState<List<Movie>>, Initial,
          Loading, Success<List<Movie>>, Failure>(
        builder: (ctx, state) => state(
            (initial) => Container(),
            (loading) => const Center(
                  child: CircularProgressIndicator(),
                ),
            (success) => _Container(items: success.result.take(5).toList()),
            (failure) => Container()),
      ),
    );
  }
}

class _Container extends StatefulWidget {
  final List<Movie> items;
  const _Container({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  State<_Container> createState() => _ContainerState();
}

class _ContainerState extends State<_Container> {
  int selectedIndex = 0;
  final controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          carouselController: controller,
          options: CarouselOptions(
            aspectRatio: 19/9,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 30),
              onPageChanged: (index, reason) =>
                  setState(() => selectedIndex = index)),
          items: widget.items
              .map(
                (e) => Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    CachedNetworkImage(
                      height: 500,
                      fit: BoxFit.cover,
                      imageUrl: e.backdropPath?.toImgUrlOriginal() ?? "",
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CachedNetworkImage(
                        height: 200,
                        width: 150,
                        imageUrl: e.posterPath?.toImgUrlOriginal() ?? "",
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: CarouselIndicator(
            selected: selectedIndex,
            pageCount: 5,
            onTab: (index) => controller.animateToPage(index),
          ),
        )
      ],
    );
  }
}

class CarouselIndicator extends StatefulWidget {
  final int pageCount;
  final ValueChanged<int>? onTab;
  final int selected;
  const CarouselIndicator({
    Key? key,
    required this.pageCount,
    this.onTab,
    required this.selected,
  }) : super(key: key);

  @override
  State<CarouselIndicator> createState() => _CarouselIndicatorState();
}

class _CarouselIndicatorState extends State<CarouselIndicator> {
  int? hoverIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: Iterable<int>.generate(widget.pageCount)
          .map((index) => SizedBox.square(
                dimension: 16,
                child: Transform.scale(
                  scale:
                      hoverIndex == index || widget.selected == index ? 1.5 : 1,
                  child: Card(
                    elevation: 16,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: InkWell(
                      onTap: () => widget.onTab?.call(index),
                      onHover: (hovered) {
                        setState(() {
                          if (hovered) {
                            hoverIndex = index;
                          } else {
                            hoverIndex = null;
                          }
                        });
                      },
                      child: Container(),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
