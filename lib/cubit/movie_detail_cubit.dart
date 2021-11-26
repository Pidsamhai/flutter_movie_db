import 'package:bloc/bloc.dart';
import 'package:movie_db/api/response/movie_detail.dart';
import 'package:movie_db/api/response/upcoming_response.dart';
import 'package:movie_db/api/tmdb_api_services.dart';
import 'package:movie_db/cubit/basic_state.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';

import 'base_state.dart';

class MovieDetailCubit extends Cubit<BasicState<MovieDetail>> {
  final TMDBApiServices _repository;
  static const unions =
      Quartet<Initial, Loading, Success<MovieDetail>, Failure>();
  MovieDetailCubit(this._repository) : super(BasicState.initial(unions));

  Future init(String id) async {
    if (state is Success) return;
    try {
      emit(BasicState.loading(unions));
      var res = await _repository.getMovieDetail(id);
      emit(BasicState.success(unions, data: res));
    } catch (e) {
      emit(BasicState.failure(unions, error: e.toString()));
    }
  }
}
