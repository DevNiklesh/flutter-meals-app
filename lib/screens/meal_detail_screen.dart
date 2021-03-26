import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  final Function toggleFavourite;
  final Function isMealFavourite;

  MealDetailScreen(this.toggleFavourite, this.isMealFavourite);

  Widget buildSectionTitle(BuildContext context, String sectionName) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        sectionName,
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }

  Widget buildContainer(child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 300,
      width: 350,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final Meal selectedMeal =
        DUMMY_MEALS.firstWhere((element) => mealId == element.id);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
              ListView.builder(
                itemBuilder: (context, index) => Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: Text(
                      selectedMeal.ingredients[index],
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(
              ListView.builder(
                itemBuilder: (context, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          '# ${(index + 1)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      title: Text(
                        selectedMeal.steps[index],
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Divider()
                  ],
                ),
                itemCount: selectedMeal.steps.length,
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isMealFavourite(mealId) ? Icons.star : Icons.star_border,
        ),
        onPressed: () => toggleFavourite(mealId),
      ),
    );
  }
}
