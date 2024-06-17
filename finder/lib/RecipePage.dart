import 'package:flutter/material.dart';
// import 'food_card.dart';
import 'package:flutter/cupertino.dart';
// import 'package:foodfinder_app/data.dart';

import 'package:foodfinder_app/data.dart';


class RecipePage extends StatelessWidget {
  const RecipePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Icon(CupertinoIcons.arrow_left),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 8,
                bottom: 8,
              ),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(36),
                  color: Colors.black,
                ),
                child: Center(
                  child: Text(
                    currentUser.firstletter,
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
        body: Container(
          margin: const EdgeInsets.only(
            top: 8,
            right: 20,
            left: 20,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect( // Ausnahme für bilder!! clipROUNDEDrect notwendig
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/images/nudeln_mit_walnuessen.png',
                          fit: BoxFit.cover,
                          height: 250,
                          // width: 150,
                        ),
                      ),
                    )
                  ],
                ),
                // TITLE & +/heart ICONS
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nudeln mit Walnüssen',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 24,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Row(
                        children: [
                          Icon(CupertinoIcons.add_circled, size: 32),
                          SizedBox(width: 6), // Add some space between the icons if needed
                          Icon(CupertinoIcons.heart, size: 32, ),
                        ],
                      ),
                    ],
                  ),
                ),
                // TAGS
                Container(
                  // width: 190,
                  height: 24,
                  // color: Theme.of(context).colorScheme.primary,
                  margin: EdgeInsets.only(top: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 24,
                        margin: EdgeInsets.only(right: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onSecondary,
                          borderRadius: BorderRadius.circular(1000),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 12, left: 12),
                          child: Text(
                            "vegan",
                            style:Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 24,
                        margin: EdgeInsets.only(right: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1000),
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(right: 4, left: 4),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Icon(Icons.euro, size: 16),
                              Icon(Icons.euro, size: 16),
                              Icon(Icons.euro, size: 16),
                            ],
                          ),
                        )
                      ),
                      Container(
                        height: 24,
                        margin: EdgeInsets.only(right: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1000),
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(right: 12, left: 12),
                          child: Icon(
                            Icons.schedule,
                            size: 16,
                          ),
                        ),
                      ),
                      Container(
                          height: 24,
                          margin: EdgeInsets.only(right: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1000),
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(right: 12, left: 12),
                            child: Row(
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.water_drop_outlined,
                                  size: 16,
                                ),
                                Icon(
                                  Icons.water_drop_outlined,
                                  size: 16,
                                ),
                              ],
                            )
                          )
                      )
                    ],
                  ),
                ),
                // DESCRIPTION
                Container(
                  margin: EdgeInsets.only(top: 12),
                  child: Text(
                    'Der frische und gesunde Klassiker für den schnellen Genuss lorem impsum lorem ipsum frische und gesunde Klassiker für den schnellen Genuss lorem impsum lorem ipsum frische und gesunde Klassiker für den.',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                // ZUBEREITUNG - Heading
                Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Text(
                    'Zubereitung',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // ZUBEREITUNG - Content
                Container(
                  margin: EdgeInsets.only(top: 6),
                  child: OrderedList(
                    items: const [
                      'Lass das Mehl mit Wasser quellen und dann 2h stehen.',
                      'Kratze das Innere aus der Zucchini und mische es mit dem Käse und dem Hackfleisch.',
                      'Die gefüllte Zucchini muss bei 200°C für 35 Minuten gebacken werden.'
                    ],
                  ),
                )
              ]
          ),
        )
      )
    );
  }
}


// helper for ordered List
class OrderedList extends StatelessWidget {
  final List<String> items;

  OrderedList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(items.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${index + 1}. ',
                style: TextStyle(fontSize: 18),
              ),
              Expanded(
                child: Text(
                  items[index],
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}