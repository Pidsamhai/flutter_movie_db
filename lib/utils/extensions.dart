import 'package:flutter/material.dart';
import 'package:movie_db/const.dart';
import 'package:responsive_framework/responsive_framework.dart';

extension StringExtension on String {
  String toImgUrl({int? width}) {
    return baseImageEnpoint.replaceAll(":v", (width ?? 300).toString()) + this;
  }

  String toImgUrlOriginal() {
    return baseImageEnpointOriginal + this;
  }
}

extension BuildContextExtions on BuildContext {
  ResponsiveWrapperData get responsive => ResponsiveWrapper.of(this);
}
