import 'package:flutter/material.dart';
import '../widgets/meals_iteam.dart';
import '../models/meal.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeal;
  FavoritesScreen(this.favoriteMeal);
  @override
  Widget build(BuildContext context) {
    if (favoriteMeal.isEmpty) {
      return Center(
        child: Text(
          'You have no favorite yet - start adding some!'
        ),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favoriteMeal[index].id,
            title: favoriteMeal[index].title,
            affordability: favoriteMeal[index].affordability,
            complexity: favoriteMeal[index].complexity,
            imageUrl: favoriteMeal[index].imageUrl,
            duration: favoriteMeal[index].duration,
          );
        },
        itemCount: favoriteMeal.length,
      );

    }
  }
}
