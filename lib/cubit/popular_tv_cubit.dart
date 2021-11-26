import 'package:bloc/bloc.dart';
import 'package:movie_db/api/response/poplar_tv.dart';
import 'package:movie_db/api/tmdb_api_services.dart';
import 'package:movie_db/cubit/base_state.dart';
import 'package:movie_db/cubit/basic_state.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';

class PopularTvCubit extends Cubit<BasicState<List<Tv>>> {
  static const unions =
      Quartet<Initial, Loading, Success<List<Tv>>, Failure>();
  final TMDBApiServices _repository;
  PopularTvCubit(this._repository) : super(BasicState.initial(unions));

  Future init() async {
    if (state is Success) return;
    try {
      emit(BasicState.loading(unions));
      var res = await _repository.getPopularTv();
      emit(BasicState.success(unions, data: res.results));
    } catch (e) {
      emit(BasicState.failure(unions, error: e.toString()));
    }
  }
}
