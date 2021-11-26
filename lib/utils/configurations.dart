import 'package:flutter/foundation.dart'
    show kIsWeb, TargetPlatform, defaultTargetPlatform;
import 'package:flutter/material.dart';

final isMobileAndTablet = [
  TargetPlatform.iOS,
  TargetPlatform.android,
].contains(defaultTargetPlatform);

final isDesktop = [
  TargetPlatform.windows,
  TargetPlatform.macOS,
  TargetPlatform.linux,
].contains(defaultTargetPlatform);

final isShowWebMenu = kIsWeb && !isMobileAndTablet;

final isShowBottomMenu = !isShowWebMenu;

class Deviders {
  static final SizedBox s = buildDevider(4);
  static final SizedBox m = buildDevider(8);
  static final SizedBox l = buildDevider(16);
  static final SizedBox xl = buildDevider(24);
  static final SizedBox xxl = buildDevider(32);

  static SizedBox buildDevider(double size) => SizedBox(
        height: size,
        width: size,
      );
}
