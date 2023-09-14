import 'package:flutter_inherited_widgets/stateManager/notifier.dart';

class ThemeController extends Notifier {
  bool _isDarkModeEnabled = false;

  bool get isDarkModeEnabled => _isDarkModeEnabled;

  void toggleTheme() {
    _isDarkModeEnabled = !_isDarkModeEnabled;
    notify();
  }
}
