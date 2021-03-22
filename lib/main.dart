import 'package:flutter/material.dart';
import 'dummy_data.dart';
import './models/meal.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import 'screens/filters_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'vegan': false,
    'vegetarian': false,
    'lactose': false,
  };
  List<Meal> _availableMeal=DUMMY_MEALS;
  List<Meal> _favoriteMeal=[];

  void _setFilters(Map<String, bool> _filtersData) {
    setState(() {
      _filters = _filtersData;
      _availableMeal=DUMMY_MEALS.where((meal) {
        if (_filters['gluten']&& !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']&& !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']&& !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']&& !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }
  void toggleFavorite(String mealId){
    final existingIndex =_favoriteMeal.indexWhere((meal) => meal.id==mealId);
    if (existingIndex>=0) {
      setState(() {
        _favoriteMeal.remove(mealId);
      });
    }  else{
      setState(() {
        _favoriteMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id==mealId));
      });
    }
  }
  bool _isMealFavorite(String id){
    return _favoriteMeal.any((meal) => meal.id==id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 234, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Color.fromRGBO(25, 45, 30, 1),
            ),
            bodyText2: TextStyle(
              color: Color.fromRGBO(25, 45, 50, 1),
            ),
            subtitle1: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      routes: {
        '/': (context) => TabsScreen(_favoriteMeal),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(_availableMeal),
        MealDetailScreen.routeName: (context) => MealDetailScreen(toggleFavorite,_isMealFavorite),
        FiltersScreen.routeName: (context) => FiltersScreen(_filters,_setFilters),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meal App"),
      ),
      body: null,
    );
  }
}
