import 'package:flutter/material.dart';

class CounterText extends StatelessWidget {
  const CounterText({
    super.key,
    required int counter,
    required Color color,
  })  : _counter = counter,
        _color = color;

  final int _counter;
  final Color _color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(color: _color, shape: BoxShape.circle),
      child: Center(
        child: Text(
          '$_counter',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
