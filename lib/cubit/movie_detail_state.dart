
import 'package:movie_db/api/response/movie_detail.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';

import 'base_state.dart';

class MovieDetailState
    extends Union4Impl<Initial, Loading, MovieDetailSuccess, Failure> {
  static const unions =
      Quartet<Initial, Loading, MovieDetailSuccess, Failure>();

  MovieDetailState._(
      Union4<Initial, Loading, MovieDetailSuccess, Failure> union)
      : super(union);

  factory MovieDetailState.initial() =>
      MovieDetailState._(unions.first(const Initial()));

  factory MovieDetailState.loading() =>
      MovieDetailState._(unions.second(const Loading()));

  factory MovieDetailState.success({required MovieDetail data}) =>
      MovieDetailState._(unions.third(MovieDetailSuccess(data)));

  factory MovieDetailState.failure({required String error}) =>
      MovieDetailState._(unions.fourth(Failure(error: error)));
}


class MovieDetailSuccess {
  final MovieDetail movieDetail;
  MovieDetailSuccess(this.movieDetail);
}
