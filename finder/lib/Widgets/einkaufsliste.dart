import 'package:foodfinder_app/Widgets/NeuesProdukt.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Einkaufsliste extends StatefulWidget {
  const Einkaufsliste({super.key});

  @override
  _EinkaufslisteState createState() => _EinkaufslisteState();
}

class _EinkaufslisteState extends State<Einkaufsliste> {
  bool isEinkaufslisteSelected = true; // Ist man auf der Seite Einkaufliste (oder Wochenplanner)
  bool isWochenplanSelected = false; // Ist man auf dem Wochenplaner
  bool isCircleSelected = false; // um produkt als gekauft zu markieren
  List<String> items = [];
  final List<Widget> _einkaufslisteWidgets = []; // liste der widgets für die liste

  @override
  void initState() {
    loadEinkaufsliste();
    super.initState();
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: const Color(0xFFFFF8F5),
        // Hintergrundfarbe der gesamten Seite
        body: Padding(
          padding: const EdgeInsets.only( //padding der seite
            left: 30,
            right: 30,
            bottom: 20,
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 60, // padding unter "einkaufsliste" und "Wochenplan"
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector( // wenn man auf einkaufsliste drückt. noch passiert nichts
                      onTap: () {
                        setState(() {
                          isEinkaufslisteSelected = true;
                          isWochenplanSelected = false;
                        });
                      },

                      child: Column(
                        children: [
                          Text(
                            'Einkaufsliste',
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container( // Linie unter Einkaufsliste
                            height: 3,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector( // wenn man auf wochenplan drückt. noch passiert nichts, aber man sollte dann auf wochenplan kommen
                      onTap: () {
                        //if()
                        setState(() {
                          isEinkaufslisteSelected = false;
                          isWochenplanSelected = true;
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            'Wochenplan',
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Container( // Linie unter Wochenplan
                            height: 3,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Container für neues Produkt:
              ..._einkaufslisteWidgets,
              const SizedBox(height: 20), // space zwischen dem untersten produkt und dem "Hinzufügen" button
          // Hinzufügen Button:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      _einkaufslisteWidgets.add(Neuesprodukt(
                        Menge: "",
                        Produktname: "",
                        Abgehakt: false,
                        stelle: items.length,
                      ));
                      setState(() {

                      });
                    },
                    child: Container( //button zum hinzufügen
                      width: 160,
                      height: 35,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5DC51),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add_circle_outline,
                            color: Colors.black,
                            size: 16,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Hinzufügen',
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );
    }

    void loadEinkaufsliste() async{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      items = prefs.getStringList('SavedList') ?? [];

      for(int i = 0; i < items.length; i++){
        String Produkt = items[i];
        List Werte = Produkt.split(', ');
        bool Gekauft = true;
        if (Werte[2].toString() == 'Gekauft'){
          Gekauft = true;
        }
        else if (Werte[2].toString() == 'Nicht gekauft'){
          Gekauft = false;
        }

        print("GEKAUFT:" + Werte[2]);
        print(Werte[2].toString() == "Nicht gekauft");

        _einkaufslisteWidgets.add(Neuesprodukt(Produktname: Werte[0], Menge: Werte[1], Abgehakt: Gekauft, stelle: i));
      }
      setState(() {

      });
    }

  }


