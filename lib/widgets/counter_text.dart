import 'package:flutter/material.dart';
import 'package:flutter_inherited_widgets/pages/my_home_page.dart';
import 'package:flutter_inherited_widgets/widgets/animated_text.dart';

class CounterText extends StatelessWidget {
  const CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = MyHomePageProvider.of(context);

    return Container(
      height: 100,
      width: 100,
      decoration:
          BoxDecoration(color: homeProvider.color, shape: BoxShape.circle),
      child: const AnimatedText(),
    );
  }
}
