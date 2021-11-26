import 'package:bloc/bloc.dart';
import 'package:movie_db/api/response/upcoming_response.dart';
import 'package:movie_db/api/tmdb_api_services.dart';
import 'package:movie_db/cubit/basic_state.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';

import 'base_state.dart';

class UpcomingCubit extends Cubit<BasicState<List<Movie>>> {
  final TMDBApiServices _apiServices;
  static const unions =
      Quartet<Initial, Loading, Success<List<Movie>>, Failure>();
  UpcomingCubit(this._apiServices) : super(BasicState.initial(unions));
  Future init() async {
    try {
      if (state is Success<List<Movie>>) return;
      emit(BasicState.loading(unions));
      var res = await _apiServices.getUpcomingMovie();
      emit(BasicState.success(unions, data: res.results));
    } catch (e) {
      emit(BasicState.failure(unions, error: e.toString()));
    }
  }
}
