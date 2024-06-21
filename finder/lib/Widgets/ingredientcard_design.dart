import 'package:flutter/material.dart';
import 'package:foodfinder_app/Data/ingredientcard.dart';

class IngredientcardDesign extends StatelessWidget {
  final Ingredientcard ingredientcard;
  const IngredientcardDesign({super.key, required this.ingredientcard});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10,top: 5, bottom: 5),
      child: Container(
        width: double.infinity,
        height: 40,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(40),
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
                  const Icon(Icons.circle_outlined, size:15, ),
                  const SizedBox(width: 7,),
                  Text(
                      ingredientcard.ingredientname,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 16,
                        letterSpacing: 0,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                ],
              ),
              Text(
                  ingredientcard.ingredientcount,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 16,
                    letterSpacing: 0,
                    fontWeight: FontWeight.bold,
                  )
              ),
            ]
        ),
      ),
    );
  }
}
