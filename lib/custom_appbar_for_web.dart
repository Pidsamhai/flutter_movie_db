import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/cubit/theme_manager_cubit.dart';
import 'package:movie_db/router/route.dart';
import 'package:movie_db/widget/menu_item.dart';
import 'package:provider/provider.dart';

class CustomBottomAppBar extends StatefulWidget {
  final GlobalKey<BeamerState> beamerKey;
  final List<String> allowPath;

  const CustomBottomAppBar(
      {Key? key, required this.beamerKey, required this.allowPath})
      : super(key: key);

  @override
  _CustomBottomAppBarState createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  late final BeamerDelegate _beamerDelegate;
  int _currentIndex = 0;
  void _setStateListener() => setState(() {});

  @override
  void initState() {
    super.initState();
    _beamerDelegate = widget.beamerKey.currentState!.routerDelegate;
    _beamerDelegate.addListener(_setStateListener);
  }

  @override
  void dispose() {
    _beamerDelegate.removeListener(_setStateListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _currentIndex = _beamerDelegate.currentBeamLocation is HomeLocation ? 0 : 1;
    var isAlow = _beamerDelegate.currentBeamLocation.state.uri.pathSegments
        .firstWhere(
          (element) => widget.allowPath.contains(element),
          orElse: () => "",
        )
        .isNotEmpty;
    return isAlow
        ? BottomNavigationBar(
            currentIndex: _currentIndex,
            items: const [
              BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  label: 'Bookmarks', icon: Icon(Icons.bookmark)),
            ],
            onTap: (index) => _beamerDelegate.beamToNamed(
              index == 0 ? '/home' : '/bookmarks',
            ),
          )
        : const SizedBox();
  }
}

class CustomAppBar extends StatefulWidget {
  final GlobalKey<BeamerState> beamerKey;

  const CustomAppBar({Key? key, required this.beamerKey}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  late final BeamerDelegate _beamerDelegate;
  void _setStateListener() => setState(() {});

  @override
  void initState() {
    super.initState();
    _beamerDelegate = widget.beamerKey.currentState!.routerDelegate;
    _beamerDelegate.addListener(_setStateListener);
  }

  @override
  void dispose() {
    _beamerDelegate.removeListener(_setStateListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeManagerBloc = context.read<ThemeManagerCubit>();
    return AppBar(
      flexibleSpace: SizedBox(
        height: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MenuItem(
                onTab: () => _beamerDelegate.beamToNamed(
                  "home",
                  popBeamLocationOnPop: true,
                ),
                widget: const Text(
                  "Movie DB",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () => _beamerDelegate.beamToNamed("/bookmarks"),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Bookmarks",
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ),
              BlocBuilder<ThemeManagerCubit, ThemeMode>(
                builder: (context, state) {
                  return MenuItem(
                    onTab: () => showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(
                          MediaQuery.of(context).size.width, 58, 0, 0),
                      items: [
                        ThemeMenuItem(
                          context: context,
                          title: "Dark",
                          onTab: themeManagerBloc.setToDark,
                          selected: state == ThemeMode.dark,
                        ),
                        ThemeMenuItem(
                          context: context,
                          title: "Light",
                          onTab: themeManagerBloc.setToLight,
                          selected: state == ThemeMode.light,
                        ),
                        ThemeMenuItem(
                          context: context,
                          title: "System",
                          onTab: themeManagerBloc.setToSystem,
                          selected: state == ThemeMode.system,
                        ),
                      ],
                    ),
                    widget: Text("Theme",
                        style: Theme.of(context).textTheme.button),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ThemeMenuItem extends PopupMenuItem {
  final VoidCallback onTab;
  final String title;
  final bool selected;
  final BuildContext context;

  const ThemeMenuItem({
    Key? key,
    required this.onTab,
    required this.title,
    required this.selected,
    required this.context,
  }) : super(key: key, child: null, onTap: onTab);

  @override
  Widget? get child => Wrap(
        direction: Axis.horizontal,
        spacing: 8,
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: selected ? const Icon(Icons.check) : null,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.button,
          )
        ],
      );
}
