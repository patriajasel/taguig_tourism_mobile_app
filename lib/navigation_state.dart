import 'package:flutter/widgets.dart';

class NavigationState extends InheritedWidget {
  final int selectedIndex;
  final ValueChanged<int> onChangeScreen;

  const NavigationState({
    super.key,
    required this.selectedIndex,
    required this.onChangeScreen,
    required super.child,
  });

  static NavigationState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<NavigationState>();
  }

  @override
  bool updateShouldNotify(NavigationState oldWidget) {
    return oldWidget.selectedIndex != selectedIndex;
  }
}
