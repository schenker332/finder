import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Planer",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36),
                color: Colors.black,
              ),
              child: Center(
                child: Text(
                  "F", //Initialien
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
=======
    return Container(
      color: Colors.grey,
    );
>>>>>>> origin/main
  }
}
