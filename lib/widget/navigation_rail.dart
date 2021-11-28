import 'package:flutter/material.dart';
import 'package:movie_db/utils/configurations.dart';

class CustomNavigationRailItem {
  final String title;
  final Icon icon;
  final Icon selectedIcon;
  CustomNavigationRailItem(
      {required this.title, required this.icon, required this.selectedIcon});
}

class _CustomNavigationRailItemWidget extends StatelessWidget {
  final CustomNavigationRailItem item;
  final VoidCallback onTab;
  final bool selected;

  const _CustomNavigationRailItemWidget({
    Key? key,
    required this.item,
    required this.onTab,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: onTab,
      child: SizedBox.square(
        dimension: 56,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              selected ? item.selectedIcon.icon : item.icon.icon,
              color: selected ? Colors.red : null,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomNavigationRail extends StatefulWidget {
  final bool visible;
  final Color selectedColor;
  final List<CustomNavigationRailItem>? items;
  final Widget child;
  final int selected;
  final ValueChanged<int> onTab;

  const CustomNavigationRail({
    Key? key,
    this.items,
    required this.child,
    this.selectedColor = Colors.red,
    required this.selected,
    required this.onTab,
    required this.visible,
  }) : super(key: key);

  @override
  _CustomNavigationRailState createState() => _CustomNavigationRailState();
}

class _CustomNavigationRailState extends State<CustomNavigationRail> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.visible) ...[
          Container(
            padding: const EdgeInsets.only(top: 6, bottom: 6),
            width: 56,
            child: Column(
                children: widget.items
                        ?.asMap()
                        .entries
                        .map((e) => _CustomNavigationRailItemWidget(
                              item: e.value,
                              onTab: () => widget.onTab(e.key),
                              selected: widget.selected == e.key,
                            ))
                        .toList() ??
                    []),
          )
        ],
        Expanded(
          child: Container(
            child: widget.child,
          ),
        )
      ],
    );
  }
}
