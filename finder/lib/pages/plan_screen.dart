import 'package:flutter/material.dart';
import 'package:foodfinder_app/pages/einkaufsliste.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 8.0,
          shadowColor: const Color(0xFFFFFBF9),
          surfaceTintColor: const Color(0xFFFFFBF9),
          title: Padding(
            padding: EdgeInsets.only(left: 8, top: 18, bottom: 12),
            child: Text(
              "Planer",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(),
            ),
          ),
        ),
        body: Einkaufsliste(),
      ),
    );
  }
}
