import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final VoidCallback? onTab;
  final ValueChanged<bool>? onHover;
  final Widget widget;
  const MenuItem({Key? key, this.onTab, required this.widget, this.onHover})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      onHover: onHover,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: widget,
      ),
    );
  }
}
