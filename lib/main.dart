import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/home/provider/home.provider.dart';
import 'package:weather_app/pages/home/view/home.view.dart';
import 'package:weather_app/pages/settings/provider/theme.provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: context.watch<ThemeProvider>().themeData,
      // darkTheme: darkTheme,
      home: const HomeView(),
    );
  }
}
