import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_items.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meal';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String _categoryTitle = '';
  List<Meal> _displayedMeals = [];
  bool _loadedInitData = false;

  @override
  void initState() {
    // run before build()
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // run after build()
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      final categoryId = routeArgs['id'];
      _categoryTitle = routeArgs['title'] as String;
      _displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      _displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryTitle),
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return MealItem(
              id: _displayedMeals[index].id,
              title: _displayedMeals[index].title,
              imageUrl: _displayedMeals[index].imageUrl,
              duration: _displayedMeals[index].duration,
              complexity: _displayedMeals[index].complexity,
              affordability: _displayedMeals[index].affordability,
              removeItem: _removeMeal,
            );
          },
          itemCount: _displayedMeals.length,
        ),
      ),
    );
  }
}
