import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_inherited_widgets/stateManager/notifier.dart';

class HomeController extends Notifier {
  int _counter = 0;
  Color _color = Colors.deepPurple;

  int get counter => _counter;
  Color get color => _color;

  void incrementCounter() {
    _counter++;

    final randomIndex = Random().nextInt(
      Colors.primaries.length - 1,
    );

    _color = Colors.primaries[randomIndex];

    notify();
  }
}
