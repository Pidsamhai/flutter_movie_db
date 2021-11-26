import 'package:movie_db/api/response/movie_credits.dart';
import 'package:movie_db/api/tmdb_api_services.dart';
import 'package:movie_db/cubit/base_state.dart';
import 'package:movie_db/cubit/basic_state.dart';
import 'package:sealed_unions/factories/quartet_factory.dart';

class MovieCreditsCubit extends BasicCubit<MovieCredits> {
  final TMDBApiServices _repository;
  static const unions =
      Quartet<Initial, Loading, Success<MovieCredits>, Failure>();
  MovieCreditsCubit(this._repository) : super(BasicState.initial(unions));

  Future init(String id) async {
    emit(BasicState.loading(unions));
    try {
      var res = await _repository.getMovieCredits(id);
      emit(BasicState.success(unions, data: res));
    } catch (e) {
      emit(BasicState.failure(unions, error: e.toString()));
    }
  }
}
