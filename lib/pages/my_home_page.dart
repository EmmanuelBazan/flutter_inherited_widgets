import 'package:flutter/material.dart';
import 'package:flutter_inherited_widgets/global/home_controller.dart';
import 'package:flutter_inherited_widgets/global/theme_controller.dart';
import 'package:flutter_inherited_widgets/stateManager/consumer.dart';
import 'package:flutter_inherited_widgets/stateManager/provider.dart';
import 'package:flutter_inherited_widgets/widgets/counter_text.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Provider<HomeController>(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
          actions: [
            Consumer<ThemeController>(
              builder: (_, controller) => Switch(
                  value: controller.isDarkModeEnabled,
                  onChanged: (_) {
                    controller.toggleTheme();
                  }),
            )
          ],
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              SizedBox(height: 5),
              CounterText(),
            ],
          ),
        ),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            onPressed: () {
              Provider.of<HomeController>(context).incrementCounter();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          );
        }), // This trailing comma makes auto-formatting nicer for build methods.
      ),
      create: () => HomeController(),
    );
  }
}
