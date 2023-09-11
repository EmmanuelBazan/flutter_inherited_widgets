import 'package:flutter/material.dart';
import 'package:flutter_inherited_widgets/pages/my_home_page.dart';

class AnimatedText extends StatelessWidget {
  const AnimatedText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homeProvider = MyHomePageProvider.of(context);

    return Center(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: Text(
          key: UniqueKey(),
          '${homeProvider.counter}',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
