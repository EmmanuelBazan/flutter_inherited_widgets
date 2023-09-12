
# Inherited Widgets in Flutter

When the app gets larger and the widget tree gets more complex, passing and accessing data can get cumbersome if you have four or five widgets nested one after the other, and there's pieces of data that you need to get from the top to the bottom so you need to specify these pieces of data through all the constructors and all the build methods.

Inherited widgets allow you to reach data from the top to the bottom in an easy way, When you put this widget on your widget tree you can get a reference to it from any widget below it.

## Indice 

1. [**Problem statement**]()

-  [MyApp]()
-  [MyHomePage]()
-  [CounterText]()
-  [AnimatedText]()
-  [Problem]()

2. [**InheritedWidget implementation**]()

-  [MyHomeProvider]()
-  [Access the data of the InheritedWidget]()
-  [CounterText accessing MyHomeProvider]()
-  [AnimatedText accessing MyHomeProvider]()
## Problem statement

We have the basic counter of a new flutter project but with some modifications. Each time you tap in the button the number of taps in the screen increments and the circle color changes randomly.
#### MyApp

First of all, we have the “MyApp” widget that contains the “MyHomePage” widget.
```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
```
#### MyHomePage

“MyHomePage” is a StatefulWidget that will handle the state of the counter and the dynamic background color.

In the state of the widget, I define an int variable equal to zero to handle the number of taps and a variable of type “Color” equal to “Colors.deepPurple” to handle the Counter background color.

I define the “_incrementCounter” function to increment my variable “_counter” and update my variable “_color” to a random value, this function is executed each time the button is pressed.
```dart
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
```
In the “build” function of the widget i have a “Scaffold” widget that container the “AppBar” widget, a “FloatingActionButton” widget that will execute the “_incrementCounter” function and in the body i have a “Center” that contains a “Column” that contains the “CounterText” widget that need like parameters counter and color.

In the “CounterText” widget i send the “_counter” and “_color” variables.
```dart
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
            CounterText(
              counter: _counter,
              color: _color,
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
```

<details>
<summary>Complete view “MyHomePage”</summary>

```dart
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
            CounterText(
              counter: _counter,
              color: _color,
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
```
</details>

#### CounterText

The “CounterText” widget is a “StatelesWidget” tha recive like parameters the number of taps and the background color.

In this widget i handle the background color of a “Container” widget and i send the taps number like parameter in the child widget “AnimatedText”.

```dart
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
      child: AnimatedText(counter: _counter),
    );
  }
}
```
#### AnimatedText

The “AnimatedText” is a “StatelesWidget” that involves the taps number in a “AnimatedSwitcher” widget to animate it each time the value change.

This widget recive like parameter the taps number to show it to the final user.

```dart
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
```
#### Problem

n this application i need to pass my variables “_counter” and ”_color” like parameters through 3 widgets to finally be used, handle this flow with three widgets in my tree could be easy but imagine handle this flow with 10 or more widgets, it becomes a pain for many developper, to solve this im going to implement the “InheritedWidget”.
## InheritedWidget implementation
#### MyHomeProvider

First of all, I need to create a class “MyHomeProvider” that will extends from “InheritedWidget”.

In “MyHomeProvider” i define the variables that im going to use througthout my app, “counter” and “color”.

Optionaly im going to create a static function that will return an instance of my “MyHomeProvider” class to facilitate their access.

```dart
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
```
#### ⚠️ updateShouldNotify override function

If this function return “true” all their child widgets that are subscribed to the changes in the “MyHomeProvider” class will be rendered again, but if return “false” they will not be rendered again.

It’s important not to return “true” always, only if it’s necesary visualize changes in the UI, for this reason we have a validation to evaluate that.

```dart
@override
  bool updateShouldNotify(MyHomePageProvider oldWidget) {
    return oldWidget.counter != counter || oldWidget.color != color;
  }
```
#### Access the data of the InheritedWidget

Once i finish to create the “MyHomeProvider” i don’t need to send my variables “_color” and “_counter” like parameters througth all my widget tree, so i can remove this parameters from the widgets that used to use them.
#### CounterText accessing MyHomeProvider

Once i removed the parameters of “CounterText” i define a “homeProvider” variable inside my build function, this variable will be an instance that i will get from my “of” function that i defined in the “MyHomeProvider” class.

It’s important that the widget who wants to access the “InheritedWidget” is it’s child.

```dart
final homeProvider = MyHomePageProvider.of(context);
```

After get a instance of “MyHomeProvider” now i can access to “color” and use it as shown in the following code snippet.

```dart
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
```
#### AnimatedText accessing MyHomeProvider

Like in the “CounterText” widget we remove the parameters and get an instance of “MyHomeProvider” to access “counter” and use it in “AnimatedText”.

```dart
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
```

And thats all, now i have an “InheritedWidget” to access it whenever i want as long as it’s a child of this widget.
