import 'package:flutter/material.dart';
import '../data/meals_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';
  final Function toggleFav;
  final Function isMealFavorite;
  const MealDetailScreen(this.isMealFavorite, this.toggleFav, {super.key});
  // const MealDetailScreen({super.key});

  Widget buildSectionTitle(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;

    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              selectedMeal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          buildSectionTitle("Ingredients"),
          buildContainer(ListView.builder(
            itemBuilder: (ctx, index) => Card(
              color: Theme.of(context).accentColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Text(selectedMeal.ingredients[index]),
              ),
            ),
            itemCount: selectedMeal.ingredients.length,
          )),
          buildSectionTitle("Steps"),
          buildContainer(ListView.builder(
            itemBuilder: (ctx, index) => Column(children: [
              ListTile(
                leading: CircleAvatar(child: Text('# ${index + 1}')),
                title: Text(selectedMeal.steps[index]),
              ),
              const Divider()
            ]),
            itemCount: selectedMeal.steps.length,
          ))
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isMealFavorite(mealId) ? Icons.star : Icons.star_outline),
        onPressed: () {
          toggleFav(mealId);
        },
      ),
    );
  }
}
