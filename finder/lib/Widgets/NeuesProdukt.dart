import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Neuesprodukt extends StatefulWidget {
  String Produktname;
  String Menge;
  bool Abgehakt;
  int stelle;
  Neuesprodukt({super.key, required this.Produktname, required this.Menge, required this.Abgehakt, required this.stelle});

  @override
  State<Neuesprodukt> createState() => _NeuesproduktState();
}

class _NeuesproduktState extends State<Neuesprodukt> {
  TextEditingController ProduktnameController = TextEditingController();
  TextEditingController MengeController = TextEditingController();
  late SharedPreferences prefs;

  @override
  void initState() {
    ProduktnameController.text = widget.Produktname;
    MengeController.text = widget.Menge;
    SharedPreferences.getInstance().then((SharedPreferences data){
      prefs = data;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container( // Container welcher ein element der einkaufsliste enthält
        //width: 300,
        height: 35, // width passt sich an seite an, padding links und rechts ist 30
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all( // umrandung des containers
            color: widget.Abgehakt ? Colors.grey : Colors.black,
            width: 1,
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0), // padding für des kreis den man auswählen kann um ein produkt als "gekauft" zu markieren
            child: Row(
              children: [
                 GestureDetector(
                   onTap: () {
                     if(widget.Abgehakt == false) {
                       widget.Abgehakt = true;
                       setState(() {
                       });
                       saveListElement();
                     }
                     else if(widget.Abgehakt == true){
                       widget.Abgehakt = false;
                       setState(() {
                       });
                       saveListElement();
                     }
                   },
                  child: Container( // kreis zum auswählen des produkts (zb wenn es gekauft wurde), noch passiert da nichts
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                        border: Border.all(
                          color: widget.Abgehakt ? Colors.grey : Colors.black,
                          width: 1,
                        )
                    ),
                    child: Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: widget.Abgehakt ? Color(0xFFF5DC51) : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                // Eingabe Produkt:
                const SizedBox(width: 10), // space zwischen kreis und "produktname eingeben"
                Expanded(
                  child:Padding(
                    padding: const EdgeInsets.only(bottom: 9),
                    child: Align(
                      alignment: Alignment.center,
                      child: TextField(
                        controller: ProduktnameController,// text feld zum eingeben des produktes
                        decoration: const InputDecoration( //textstil des texts
                          border: InputBorder.none,
                          hintText: 'Produktname eingeben', // text welcher dem user darauf hinweist dass er da ein produktnamen eingaben kann
                          hintStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                          ),
                        ),
                        onChanged: (String Value){
                          print(Value);
                          widget.Produktname = Value;
                          saveListElement();
                        },
                        style: Theme.of(context).textTheme.titleLarge!.copyWith( //textstil des texts welcher dann eingegeben wird
                          fontSize: 18,
                          color: widget.Abgehakt ? Colors.grey : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                // Eingabe Menge :
                const SizedBox(width: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 9,
                      left: 110,
                    ),
                    child: TextField(
                      controller: MengeController,// textfeld um menge einzugeben
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Menge',
                        hintStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                      ),
                      onChanged: (String Value){
                        print(Value);
                        widget.Menge = Value;
                        saveListElement();
                      },
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 18,
                        color: widget.Abgehakt ? Colors.grey : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }

  void saveListElement() async{
    String Status = '';
    if(widget.Abgehakt == true){
      Status = 'Gekauft';
    }
    else if(widget.Abgehakt == false){
      Status = 'Nicht gekauft';
    }
    String produkt = widget.Produktname + ', ' + widget.Menge + ', ' + Status;

    final List<String> items = prefs.getStringList('SavedList') ?? [];
      if(items.length > widget.stelle){
        items[widget.stelle] = produkt;
        prefs.setStringList("SavedList", items);
      }else{
        items.add(produkt);
        prefs.setStringList("SavedList", items);
      }
    }

}
