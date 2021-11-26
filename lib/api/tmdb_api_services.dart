import 'package:dio/dio.dart';
import 'package:movie_db/api/response/movie_credits.dart';
import 'package:movie_db/api/response/movie_detail.dart';
import 'package:movie_db/api/response/poplar_tv.dart';
import 'package:movie_db/api/response/upcoming_response.dart';
import 'package:movie_db/const.dart';
import 'package:retrofit/retrofit.dart';

part 'tmdb_api_services.g.dart';

@RestApi(baseUrl: baseApiEnpoint)
abstract class TMDBApiServices {
  factory TMDBApiServices(Dio dio, {String baseUrl}) = _TMDBApiServices;

  @GET("/movie/upcoming")
  Future<UpcomingResponse> getUpcomingMovie();

  @GET("/movie/{id}")
  Future<MovieDetail> getMovieDetail(@Path("id") String id);

  @GET("/tv/popular")
  Future<PopularTvResponse> getPopularTv();

  @GET("/movie/{id}/credits")
  Future<MovieCredits> getMovieCredits(@Path("id") String i);
}
