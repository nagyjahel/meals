import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  static const String routeName = '/meal-detail';

  final Function toggleFavorite;
  final Function isFavorite;

  MealDetailScreen(this.toggleFavorite, this.isFavorite);

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final Meal selectedMeal =
        DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    Widget _buildSectionTitle(BuildContext context, String text) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Text(
          text,
          style: Theme.of(context).textTheme.title,
        ),
      );
    }

    Widget _buildContainer(Widget child) {
      return Container(
        //decoration: BoxDecoration,
        height: 220,
        width: double.infinity,
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Theme.of(context).accentColor),
            borderRadius: BorderRadius.circular((10))),
        child: child,
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('${selectedMeal.title}')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            _buildSectionTitle(context, 'Ingredients'),
            _buildContainer(ListView.builder(
              itemCount: selectedMeal.ingredients.length,
              itemBuilder: (ctx, index) => Card(
                  color: Theme.of(ctx).canvasColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: Text(selectedMeal.ingredients[index]),
                  )),
            )),
            _buildSectionTitle(context, 'Steps'),
            _buildContainer(ListView.builder(
              itemCount: selectedMeal.steps.length,
              itemBuilder: (ctx, index) => ListTile(
                leading: CircleAvatar(child: Text('#${index + 1}')),
                title: Text(selectedMeal.steps[index]),
              ),
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            isFavorite(mealId) ? Icons.star : Icons.star_border,
          ),
          onPressed: (){toggleFavorite(mealId);},
    ));
  }
}
