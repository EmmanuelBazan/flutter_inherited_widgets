import 'package:flutter/material.dart';
import 'package:flutter_inherited_widgets/global/theme_controller.dart';
import 'package:flutter_inherited_widgets/pages/my_home_page.dart';
import 'package:flutter_inherited_widgets/stateManager/consumer.dart';
import 'package:flutter_inherited_widgets/stateManager/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<ThemeController>(
        //* function that return an instance of class that extends from Notifier
        create: () => ThemeController(),
        child: Consumer<ThemeController>(
          builder: (_, controller) => MaterialApp(
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
            themeMode:
                controller.isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
            home: const MyHomePage(title: 'Inherited Widget'),
          ),
        ));
  }
}
