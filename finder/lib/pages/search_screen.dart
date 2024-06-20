import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Suche",
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
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Theme.of(context).colorScheme.primary,
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 20, top: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(CupertinoIcons.search),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Was willst Du heute essen?",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
