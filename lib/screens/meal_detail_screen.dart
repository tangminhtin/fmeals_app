import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  final List<Meal> availableMeals;
  final Function toggleFavorites;
  final Function isMealFavorite;

  MealDetailScreen(
    this.availableMeals,
    this.toggleFavorites,
    this.isMealFavorite,
  );

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final selectMeal = availableMeals.firstWhere((meal) => meal.id == mealId);

    Widget buildSectionTitle(BuildContext context, String text) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: Theme.of(context).textTheme.title?.fontSize,
            fontWeight: Theme.of(context).textTheme.title?.fontWeight,
          ),
        ),
      );
    }

    Widget buildContainer(Widget child) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(25),
          color: Theme.of(context).cardColor,
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        height: 200,
        width: 300,
        child: child,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(selectMeal.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  selectMeal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              buildSectionTitle(context, 'Ingredients'),
              buildContainer(
                ListView.builder(
                  itemBuilder: (context, index) => Card(
                    color: Theme.of(context).primaryColorLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      child: Text(
                        selectMeal.ingredients[index],
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  itemCount: selectMeal.ingredients.length,
                ),
              ),
              buildSectionTitle(context, 'Steps'),
              buildContainer(
                ListView.builder(
                  itemBuilder: (context, index) => Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('#${index + 1}'),
                        ),
                        title: Text(
                          selectMeal.steps[index],
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontFamily:
                                Theme.of(context).textTheme.title?.fontFamily,
                          ),
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                  itemCount: selectMeal.steps.length,
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  child: Icon(
                    isMealFavorite(mealId)
                        ? Icons.star
                        : Icons.star_border_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () => toggleFavorites(mealId),
                  heroTag: null,
                ),
                SizedBox(width: 10),
                FloatingActionButton(
                  child: Icon(
                    Icons.delete,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(mealId);
                  },
                  heroTag: null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
