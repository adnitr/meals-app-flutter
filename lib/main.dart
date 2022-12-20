import 'package:flutter/material.dart';

import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Addy Meals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'RaleWay',
        // textTheme: ThemeData.light().textTheme.copyWith(
        //       bodyText1:
        //           const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
        //       bodyText2:
        //           const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
        //       // titleMedium: const TextStyle(
        //       //   fontSize: 24,
        //       //   fontFamily: 'RobotoCondensed',
        //       // ),)
      ),
      home: const CategoriesScreen(),
      routes: {'/category-meals': (ctx) => const CategoryMealsScreen()},
    );
  }
}
