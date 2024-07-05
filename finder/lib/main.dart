import 'package:flutter/material.dart';
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
  List<Widget> screens = [HomeScreen(), SearchScreen(), CreateScreen(), PlanScreen(), FavoriteScreen() ];




  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "FoodFinder",
      debugShowCheckedModeBanner: false,


      theme: ThemeData(                                 //hier wird das Theme festgelegt
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
                ),







                child: Container(        //hier gehts los mit der Navigation
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,    //hier werden die einzelnen Seiten in den Container gepackt






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
                              color: Colors.white,
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
                            color: Colors.white,
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
                            color: Colors.white,
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
                            color: Colors.white,
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
                              color: Colors.white,
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
                ),  //hier passiert die ganze Navigation











              ),

            ],
          ),
        ),
      ),

    );
  }
}