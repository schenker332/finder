import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'food_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                    "F",  //Initialien
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
                      fontSize: 24,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Icon(CupertinoIcons.arrow_right),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: FoodCard(
                title: "Nudeln mit Walnüssen",
                imagePath: "https://media.istockphoto.com/id/1680097339/de/foto/rigatoni-nudeln-in-basilikum-pesto-w%C3%BCrzige-italienische-pasta.jpg?s=1024x1024&w=is&k=20&c=4h6c_m9Tv54mMwExNJ4XhzQUBnzglXhIUUnLa8BH8Og=",
                isVegan: true,
                price: 3.0,
                description: "Der frische und gesunde Klassiker für den schnellen Genuss lorem impsum lorem ipsum",
                availability: "Heute",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
