import 'package:flutter/material.dart';
import 'package:flutter_inherited_widgets/global/home_controller.dart';
import 'package:flutter_inherited_widgets/stateManager/consumer.dart';

class AnimatedText extends StatelessWidget {
  const AnimatedText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: Consumer<HomeController>(
          builder: (_, controller) => Text(
            key: UniqueKey(),
            '${controller.counter}',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }
}
