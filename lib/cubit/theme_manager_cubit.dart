import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_manager_state.dart';

class ThemeManagerCubit extends Cubit<ThemeMode> {
  static const themeManagerKey = "theme_manager";
  static const dark = "dark";
  static const light = "light";
  static const system = "system";
  final SharedPreferences _pref;
  ThemeManagerCubit(this._pref)
      : super(_getThemePreferences(_pref.getString(themeManagerKey)));

  void setToDark() {
    _pref.setString(themeManagerKey, dark);
    emit(ThemeMode.dark);
  }

  void setToLight() {
    _pref.setString(themeManagerKey, light);
    emit(ThemeMode.light);
  }

  void setToSystem() {
    _pref.setString(themeManagerKey, system);
    emit(ThemeMode.system);
  }

  static ThemeMode _getThemePreferences(String? theme) {
    if (theme == dark) {
      return ThemeMode.dark;
    } else if (theme == light) {
      return ThemeMode.light;
    } else {
      return ThemeMode.system;
    }
  }
}
