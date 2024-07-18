import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Neuesprodukt extends StatefulWidget {
  String Produktname;
  String Menge;
  bool Abgehakt;
  final int stelle;
  final bool isInteractive;
  final VoidCallback onSave;

  Neuesprodukt({
    super.key,
    required this.Produktname,
    required this.Menge,
    required this.Abgehakt,
    required this.stelle,
    this.isInteractive = true,
    required this.onSave
  });

  @override
  State<Neuesprodukt> createState() => _NeuesproduktState();
}

class _NeuesproduktState extends State<Neuesprodukt> {
  TextEditingController ProduktnameController = TextEditingController();
  TextEditingController MengeController = TextEditingController();
  late SharedPreferences prefs;

  get status => null;

  @override
  void initState() {
    ProduktnameController.text = widget.Produktname;
    MengeController.text = widget.Menge;
    if (widget.isInteractive) {
      SharedPreferences.getInstance().then((SharedPreferences data) {
        prefs = data;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container( // Container welcher ein element der einkaufsliste enthält
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(1000),
          border: Border.all( // umrandung des containers
            color: widget.Abgehakt ? Colors.grey : Colors.black,
            width: 1,
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0), // padding für des kreis den man auswählen kann um ein produkt als "gekauft" zu markieren
            child: Row(
              children: <Widget>[
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
                if(!widget.isInteractive)
                  Container(width: 20, height: 20),
                // Eingabe Produkt:
                const SizedBox(width: 10), // space zwischen kreis und "produktname eingeben"
                Expanded(
                  flex: 8,
                  child:Align(
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
                      onChanged: (String value){
                        widget.Produktname = value;
                        if (widget.isInteractive) {
                          saveListElement();
                        }
                      },
                      style: Theme.of(context).textTheme.titleLarge!.copyWith( //textstil des texts welcher dann eingegeben wird
                        fontSize: 18,
                        color: widget.Abgehakt ? Colors.grey : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      readOnly: !widget.isInteractive,
                    ),
                  ),
                ),

                // Eingabe Menge :
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
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
                    onChanged: (String value){
                      widget.Menge = value;
                      if (widget.isInteractive) {
                        saveListElement();
                      }
                    },
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 18,
                      color: widget.Abgehakt ? Colors.grey : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    readOnly: !widget.isInteractive,
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }

  void saveListElement() async{
    String status = widget.Abgehakt ? 'Gekauft' : 'Nicht gekauft';
    String produkt = '${widget.Produktname}, ${widget.Menge}, $status';

    final List<String> items = prefs.getStringList('SavedList') ?? [];
      if(items.length > widget.stelle){
        items[widget.stelle] = produkt;
        //prefs.setStringList("SavedList", items);
      }else{
        items.add(produkt);
        //prefs.setStringList("SavedList", items);
      }
      prefs.setStringList("SavedList", items);
      widget.onSave();
    }

}
