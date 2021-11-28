import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/api/tmdb_api_services.dart';
import 'package:movie_db/cubit/movie_credits_cubit.dart';
import 'package:movie_db/cubit/movie_detail_cubit.dart';
import 'package:movie_db/cubit/popular_tv_cubit.dart';
import 'package:movie_db/cubit/theme_manager_cubit.dart';
import 'package:movie_db/cubit/upcoming_cubit.dart';
import 'package:movie_db/router/route.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

void initQR() {
  QR.settings.enableDebugLog = kDebugMode;
  QR.settings.enableLog = kDebugMode;
}

Dio provideDio() {
  final dio = Dio();
  dio.interceptors.add(dioLoggerInterceptor);
  dio.options.queryParameters["api_key"] = "3d11a299f3553fe500655a153f9dc3e7";
  return dio;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initQR();
  final dio = provideDio();
  final SharedPreferences pref = await SharedPreferences.getInstance();
  setPathUrlStrategy();
  runApp(
    RepositoryProvider(
      create: (context) => TMDBApiServices(dio),
      child: MultiBlocProvider(providers: [
        BlocProvider<UpcomingCubit>(
          create: (BuildContext context) => UpcomingCubit(context.read()),
        ),
        BlocProvider<MovieDetailCubit>(
          create: (BuildContext context) => MovieDetailCubit(context.read()),
        ),
        BlocProvider<ThemeManagerCubit>(
          create: (BuildContext context) => ThemeManagerCubit(pref),
        ),
        BlocProvider<PopularTvCubit>(
          create: (BuildContext context) => PopularTvCubit(context.read()),
        ),
        BlocProvider<MovieCreditsCubit>(
          create: (BuildContext context) => MovieCreditsCubit(context.read()),
        )
      ], child: const MovieApp()),
    ),
  );
}

class MovieApp extends StatelessWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeManagerCubit, ThemeMode>(
      builder: (context, state) {
        return MaterialApp.router(
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
          ),
          builder: (context, widget) => ResponsiveWrapper.builder(
            widget,
            breakpoints: const [
              ResponsiveBreakpoint.autoScale(480, name: MOBILE),
              ResponsiveBreakpoint.autoScale(800, name: TABLET),
              ResponsiveBreakpoint.autoScale(1000, name: DESKTOP),
            ],
          ),
          themeMode: ThemeMode.light,
          darkTheme: ThemeData.dark(),
          theme: ThemeData.light(),
          debugShowCheckedModeBanner: false,
          routeInformationParser: const QRouteInformationParser(),
          routerDelegate: QRouterDelegate(
            AppRoutes().routes,
            withWebBar: kIsWeb,
            initPath: "/main/home",
          ),
        );
      },
    );
  }
}

// class TestPage extends StatelessWidget {
//   const TestPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     context.read<MovieCreditsCubit>().init("580489");
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.green,
//         body: Container(
//           color: Colors.red,
//           child: const CastList(movieTvId: "580489"),
//         ),
//       ),
//     );
//   }
// }
