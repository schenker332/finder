import 'package:foodfinder_app/pages/NeuesProdukt.dart';
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
  //bool isCircleSelected = false; // um produkt als gekauft zu markieren
  List<String> items = [];
  final List<Widget> _einkaufslisteWidgets = []; // liste der widgets für die liste
  bool lastElementSaved = true;

  @override
  void initState() {
    loadEinkaufsliste();
    super.initState();
  }

  @override
  void dispose() {
    SharedPreferences.getInstance().then((SharedPreferences prefs){
      items = prefs.getStringList('SavedList') ?? [];

      for(int i = 0; i < items.length; i++) {
        String produkt = items[i];
        List werte = produkt.split(', ');
        bool gekauft = werte[2].toString() == 'Gekauft';

        if(gekauft){
          items.removeAt(i);
          i--;
        }
      }

      prefs.setStringList("SavedList", items);
    });

    super.dispose();
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: const Color(0xFFFFFBF9),
        // Hintergrundfarbe der gesamten Seite
        body: Padding(
          padding: const EdgeInsets.only( //padding der seite
            left: 15,
            right: 15,
            bottom: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20, // padding unter "einkaufsliste" und "Wochenplan"
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 80.0),
                  child: Center(
                    child: GestureDetector(
                      onTap: (){
                        if(lastElementSaved){
                          _einkaufslisteWidgets.add(Neuesprodukt(
                            Menge: "",
                            Produktname: "",
                            Abgehakt: false,
                            stelle: items.length,
                            isInteractive: true,
                            onSave: () async{
                              lastElementSaved = true;
                              final SharedPreferences prefs = await SharedPreferences.getInstance();
                              items = prefs.getStringList('SavedList') ?? [];
                            },
                          ));
                          lastElementSaved = false;
                          setState(() {});
                        } else {
                          //Popup mit dem Hinweis "Du musst das letzte Element ausfüllen um ein Neues hinzuzufügen"
                        }
                      },
                      child: Container( //button zum hinzufügen
                        width: 240,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5DC51),
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_circle_outline,
                              size: 20,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Hinzufügen',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.4,
                                color: Colors.black,
                              )
                            ),
                          ],
                        ),
                      ),
                    )
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    void loadEinkaufsliste() async{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      items = prefs.getStringList('SavedList') ?? [];

      for(int i = 0; i < items.length; i++) {
        String produkt = items[i];
        //List<String> values = produkt.split(', ');
        List werte = produkt.split(', ');
        //bool Gekauft = true;
        bool gekauft = werte[2].toString() == 'Gekauft';

        _einkaufslisteWidgets.add(
          Neuesprodukt(
            Produktname: werte[0],
            Menge: werte[1],
            Abgehakt: gekauft,
            stelle: i,
            isInteractive: true,
            onSave: (){

            },
          ),
        );
      }
      setState(() {});
    }
  }


