part of 'theme_manager_cubit.dart';

class ThemeManagerState extends Union2Impl<LightTheme, DarkTheme> {
  static const unions = Doublet<LightTheme, DarkTheme>();

  ThemeManagerState._(Union2<LightTheme, DarkTheme> union) : super(union);

  factory ThemeManagerState.light() =>
      ThemeManagerState._(unions.first(const LightTheme()));

  factory ThemeManagerState.dark() =>
      ThemeManagerState._(unions.second(const DarkTheme()));
}

class LightTheme {
  const LightTheme();
}

class DarkTheme {
  const DarkTheme();
}
