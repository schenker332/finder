import 'package:flutter/material.dart';
import 'package:foodfinder_app/pages/einkaufsliste.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodfinder_app/pages/create_screen.dart';
import 'package:foodfinder_app/pages/favorite_screen.dart';
import 'package:foodfinder_app/pages/home_screen.dart';
import 'package:foodfinder_app/pages/plan_screen.dart';
import 'package:foodfinder_app/pages/search_screen.dart';

void main() {
  runApp(MyFirstApp());
}

class MyFirstApp extends StatefulWidget {
  const MyFirstApp({super.key});

  @override
  State<MyFirstApp> createState() => _MyFirstAppState();
}

class _MyFirstAppState extends State<MyFirstApp> {
  int currentPage = 0;
  int tappedPage = -1;
  List<Widget> screens = [HomeScreen(), SearchScreen(), CreateScreen(), PlanScreen(), FavoriteScreen() ];

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "FoodFinder",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          primary: Colors.white,
          onPrimary: const Color(0xFFF5DC51),
          secondary: const Color(0xFFED736B),
          onSecondary: const Color(0xFF71BD71),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFFBF9),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFFFFFBF9),
        ),
        //primaryColor: const Color(0xFFFBF9),
        textTheme: TextTheme(
          titleLarge: GoogleFonts.afacad(
            fontSize: 32,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: GoogleFonts.afacad(
            color: Colors.black,
            fontSize: 10,
            letterSpacing: 0,
          ),
        ),
      ),
      home: SafeArea(
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
                  bottom: 20,
                ),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector( // home
                        onTap: (){
                          currentPage = 0;
                          setState(() {});
                        },
                        onTapDown: (TapDownDetails details) {
                          tappedPage = 0;
                          setState(() {});
                        },
                        onTapUp: (TapUpDetails details) {
                          tappedPage = -1;
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: AnimatedContainer(
                            duration: Durations.short2,
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: currentPage == 0 ?
                                Colors.black :
                                (tappedPage == 0 ? Color.fromARGB(255, 220, 220, 220) : Colors.white ),
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            child: currentPage == 0 ?
                              Icon(CupertinoIcons.house, color: Colors.white) :
                              Icon(CupertinoIcons.house, color: Colors.black)
                          ),
                        ),
                      ), // home

                      GestureDetector( // search
                        onTap: (){
                          currentPage = 1;
                          setState(() {});
                        },
                        onTapDown: (TapDownDetails details) {
                          tappedPage = 1;
                          setState(() {});
                        },
                        onTapUp: (TapUpDetails details) {
                          tappedPage = -1;
                          setState(() {});
                        },
                        child: AnimatedContainer(
                          duration: Durations.short2,
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: currentPage == 1 ?
                              Colors.black :
                              (tappedPage == 1 ? Color.fromARGB(255, 220, 220, 220) : Colors.white ),
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: currentPage == 1 ?
                            Icon(CupertinoIcons.search, color: Colors.white) :
                            Icon(CupertinoIcons.search, color: Colors.black),
                        ),
                      ), // search

                      GestureDetector( // create
                        onTap: (){
                          currentPage = 2;
                          setState(() {});
                        },
                        onTapDown: (TapDownDetails details) {
                          tappedPage = 2;
                          setState(() {});
                        },
                        onTapUp: (TapUpDetails details) {
                          tappedPage = -1;
                          setState(() {});
                        },
                        child: AnimatedContainer(
                          duration: Durations.short2,
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: currentPage == 2 ?
                              Colors.black :
                              (tappedPage == 2 ? Color.fromARGB(255, 220, 220, 220) : Colors.white ),
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: currentPage == 2 ?
                            Icon(CupertinoIcons.add, color: Colors.white) :
                            Icon(CupertinoIcons.add, color: Colors.black)
                        ),
                      ), // create

                      GestureDetector( // planner
                        onTap: (){
                          currentPage = 3;
                          setState(() {});
                        },
                        onTapDown: (TapDownDetails details) {
                          tappedPage = 3;
                          setState(() {});
                        },
                        onTapUp: (TapUpDetails details) {
                          tappedPage = -1;
                          setState(() {});
                        },
                        child: AnimatedContainer(
                          duration: Durations.short2,
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: currentPage == 3 ?
                              Colors.black :
                              (tappedPage == 3 ? Color.fromARGB(255, 220, 220, 220) : Colors.white ),
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: currentPage == 3 ?
                            Icon(CupertinoIcons.calendar, color: Colors.white) :
                            Icon(CupertinoIcons.calendar, color: Colors.black)
                        ),
                      ), // planner

                      GestureDetector( // saved/library/gespeichert
                        onTap: () {
                          currentPage = 4;
                          setState(() {});
                        },
                        onTapDown: (TapDownDetails details) {
                          tappedPage = 4;
                          setState(() {});
                        },
                        onTapUp: (TapUpDetails details) {
                          tappedPage = -1;
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: AnimatedContainer(
                            duration: Durations.short2,
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: currentPage == 4 ?
                                Colors.black :
                                (tappedPage == 4 ? Color.fromARGB(255, 220, 220, 220) : Colors.white ),
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            child: currentPage == 4 ?
                              Icon(CupertinoIcons.heart, color: Colors.white) :
                              Icon(CupertinoIcons.heart, color: Colors.black)
                          ),
                        ),
                      ), // saved/library/gespeichert
                    ],
                  ),
                ),

              ),

            ],
          ),
        ),
      ),

    );
  }
}