import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_inherited_widgets/widgets/counter_text.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Color _color = Colors.deepPurple;

  void _incrementCounter() {
    setState(() {
      _counter++;

      final randomIndex = Random().nextInt(
        Colors.primaries.length - 1,
      );

      _color = Colors.primaries[randomIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            const SizedBox(height: 5),
            MyHomePageProvider(
              color: _color,
              counter: _counter,
              child: const CounterText(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyHomePageProvider extends InheritedWidget {
  final int counter;
  final Color color;

  const MyHomePageProvider(
      {Key? key,
      required this.color,
      required this.counter,
      required Widget child})
      : super(
          key: key,
          child: child,
        );

  @override
  bool updateShouldNotify(MyHomePageProvider oldWidget) {
    return oldWidget.counter != counter || oldWidget.color != color;
  }

  static MyHomePageProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyHomePageProvider>()!;
  }
}
