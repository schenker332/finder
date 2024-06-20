import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodfinder_app/Data/Data.dart';
import 'package:foodfinder_app/Widgets/card_design.dart';
import 'package:foodfinder_app/Widgets/ingredients_box_desgin.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Hallo Franziska!", //Username Nutzername
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
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Text(
                    "Wochenplan",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 20,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(CupertinoIcons.arrow_right),
                ),
              ],
            ),
            Expanded(
              flex: 2,
              child: PageView(scrollDirection: Axis.horizontal, children: [
                ...allCards.map((oneCard) => CardDesign(card: oneCard)),
              ]),
            ),
            Container(
              width: 118,
              height: 17,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                color: Theme.of(context).colorScheme.primary,
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (int i = 0; i < 7; i++)
                    const Icon(
                      Icons.circle,
                      color: Colors.grey,
                      size: 7,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Text(
                    "Oben auf deiner Liste",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 20,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(CupertinoIcons.arrow_right),
                ),
              ],
            ),
            Expanded(
              flex: 2,
              child: ListView(
                //padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                children: [
                  ...allBoxes.map((oneBox) => IngredientsBox(box: oneBox)),
                ],
              ),
            ),
            const SizedBox(height: 0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18, top: 20),
                  child: Text(
                    "Zuletzt Gespeichert",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 20,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 15, top: 20),
                  child: Icon(CupertinoIcons.arrow_right),
                ),
              ],
            ),
            Expanded(
              flex: 2,
              child: ListView(
                //padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                children: [
                  ...allCards.map((oneCard) => CardDesign(card: oneCard)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
