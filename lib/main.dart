import 'package:flutter/material.dart';
import './data/meals_data.dart';
import './models/meal.dart';

import './screens/category_meals_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';
import './screens/filters_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoritedMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    _filters = filterData;

    _availableMeals = DUMMY_MEALS.where((meal) {
      if (_filters['gluten'] == true && !meal.isGlutenFree) {
        return false;
      }
      if (_filters['lactose'] == true && !meal.isLactoseFree) {
        return false;
      }
      if (_filters['vegan'] == true && !meal.isVegan) {
        return false;
      }
      if (_filters['vegetarian'] == true && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoritedMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        _favoritedMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoritedMeals
            .add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoritedMeals.any((meal) => meal.id == id);
  }

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
      home: TabsScreen(_favoritedMeals),
      routes: {
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_isMealFavorite, _toggleFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters)
      },
      // onUnknownRoute: (settings) {
      //   return MaterialPageRoute(builder: (ctx) => const CategoryMealsScreen());
      // },
    );
  }
}
