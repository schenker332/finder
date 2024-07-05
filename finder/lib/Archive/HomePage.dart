import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodfinder_app/pages/create_screen.dart';
import 'package:foodfinder_app/pages/favorite_screen.dart';
import 'package:foodfinder_app/pages/home_screen.dart';
import 'package:foodfinder_app/pages/plan_screen.dart';
import 'package:foodfinder_app/pages/search_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  List<Widget> screens = [HomeScreen(), SearchScreen(), CreateScreen(), PlanScreen(), FavoriteScreen() ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: screens[currentPage]
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 50,
                right: 50,
              ),
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      GestureDetector(
                        onTap: (){
                          currentPage = 0;
                          setState(() {

                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            child: Icon(CupertinoIcons.home),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: (){
                          currentPage = 1;
                          setState(() {

                          });
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: Icon(CupertinoIcons.search),
                        ),
                      ),

                      GestureDetector(
                        onTap: (){
                          currentPage = 2;
                          setState(() {

                          });
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: Icon(CupertinoIcons.add_circled),
                        ),
                      ),

                      GestureDetector(
                        onTap: (){
                          currentPage = 3;
                          setState(() {

                          });
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: Icon(CupertinoIcons.calendar_today),
                        ),
                      ),

                      GestureDetector(
                        onTap: (){
                          currentPage = 4;
                          setState(() {

                          });
                        },

                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              CupertinoIcons.heart,
                              size: 25,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                  ],
                  ),
              ),

          ),

        ],
        ),
      ),
    );
  }
}
