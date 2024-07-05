import "package:flutter/material.dart";
import 'package:foodfinder_app/Data/ingredients_box.dart';


class IngredientsBox extends StatelessWidget {
  final IngredientBox box;
  const IngredientsBox ({super.key, required this.box});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: double.infinity,
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45),
          color: Theme.of(context).colorScheme.primary,
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Row(
                children: [
                  Icon(Icons.circle_outlined, size: 18,),
                  Text(
                    box.ingredientname,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]
             ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                  box.ingredientcount,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
