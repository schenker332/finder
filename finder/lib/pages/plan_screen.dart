import 'package:flutter/material.dart';
import 'package:foodfinder_app/pages/einkaufsliste.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Planer",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(),
          ),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        ),
        body: Einkaufsliste(),
      ),
    );
  }
}
