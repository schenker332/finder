import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              child: Container(
                width: double.infinity,
                height: 132,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              "https://media.istockphoto.com/id/1680097339/de/foto/rigatoni-nudeln-in-basilikum-pesto-w%C3%BCrzige-italienische-pasta.jpg?s=1024x1024&w=is&k=20&c=4h6c_m9Tv54mMwExNJ4XhzQUBnzglXhIUUnLa8BH8Og=",
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          child: Column(
                            children: [
                              Text(
                                "Nudeln mit Walnüssen",
                                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                  fontSize: 18,
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                width: 190,
                                height: 25,
                                color: Theme.of(context).colorScheme.primary,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 15,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.onSecondary,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Vegan",
                                          style:Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            fontSize: 10,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 40,
                                      height: 15,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.black, width: 1),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.euro, size: 10),
                                          Icon(Icons.euro, size: 10),
                                          Icon(Icons.euro, size: 10),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 30,
                                      height: 15,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.black, width: 1),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.schedule,
                                          size: 10,
                                        ),
                                      ),
                                    ),
                                    Container(
                                        width: 40,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.black, width: 1),
                                        ),
                                        child: Row(
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.water_drop_outlined,
                                              size: 10,
                                            ),
                                            Icon(
                                              Icons.water_drop_outlined,
                                              size: 10,
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                              Container(
                                  width: 190,
                                  height: 45,
                                  //color: Colors.cyan,
                                  child: Column(
                                    children: [
                                      Text(
                                        "Der frische und gesunde Klassiker für den schnellen Genuss lorem impsum lorem ipsum",
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          fontSize: 10.5,
                                          letterSpacing: 0,
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                          padding: const EdgeInsets.only(
                            top: 70,
                            right: 20,
                          ),
                          child: Container(
                            width: 40,
                            height: 15,
                            child: Icon(
                              Icons.favorite,
                              size: 20,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),

      
      ),
    );
  }
}
