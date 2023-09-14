import 'package:flutter/foundation.dart';

typedef VoidCallback = void Function();

abstract class Notifier {
  final List<VoidCallback> _listeners = [];

  void notify() {
    for (var listener in _listeners) {
      listener();
    }
  }

  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  @protected
  @mustCallSuper
  void dispose() {
    _listeners.clear();
  }
}
