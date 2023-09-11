import 'package:flutter/material.dart';

class AnimatedText extends StatelessWidget {
  const AnimatedText({
    super.key,
    required int counter,
  }) : _counter = counter;

  final int _counter;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: Text(
          key: UniqueKey(),
          '$_counter',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
