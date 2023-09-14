import 'package:flutter/material.dart';
import 'package:flutter_inherited_widgets/global/home_controller.dart';
import 'package:flutter_inherited_widgets/stateManager/consumer.dart';
import 'package:flutter_inherited_widgets/widgets/animated_text.dart';

class CounterText extends StatelessWidget {
  const CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (_, controller) => Container(
        height: 100,
        width: 100,
        decoration:
            BoxDecoration(color: controller.color, shape: BoxShape.circle),
        child: const AnimatedText(),
      ),
    );
  }
}
