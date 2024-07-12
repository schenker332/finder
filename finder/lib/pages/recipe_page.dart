import 'package:flutter/material.dart';
// import 'food_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:foodfinder_app/data.dart';

// import 'package:foodfinder_app/data.dart';

bool zutatenSelectable = false;
bool zutatenWereAdded = false;
String buttonText = 'Zur Einkaufsliste hinzufügen';
// bool noZutatSelected = false; // LATER
List<bool> isZutatSelected = [];
List<List<String>> zutatenCopy = [[]];


class RecipePage extends StatefulWidget {
  List<List<String>> zutaten;
  int portionen;

  RecipePage({super.key, required this.zutaten, required this.portionen});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  String inputDisplay = '';
  TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  List<String> einkaufsliste = [];
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();

    // copy the zutaten that were handed to this widget (deep clone!)
    zutatenCopy = widget.zutaten.map((innerList) => List<String>.from(innerList)).toList();

    // copy initial portionenAmount
    inputDisplay = widget.portionen.toString();

    // init controller to display number correctly and event to handle focus loss of textfield
    _controller = TextEditingController(text: inputDisplay);
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // Trigger the onSubmitted event when the TextField loses focus
        _onSubmitted(_controller.text);
      }
    });

    // init sharedpreferences
    SharedPreferences.getInstance().then((SharedPreferences data){
      prefs = data;
    });
    super.initState();
  }

  // handles updating zutatenCopy (doesnt change initial values, just copy)
  void _onSubmitted(String inputValue) {
    setState(() {
      double multiplier = double.tryParse(inputValue) ?? 1.0;
      multiplier /= widget.portionen;
      // reset copy to initial value
      zutatenCopy = widget.zutaten.map((innerList) => List<String>.from(innerList)).toList();
      // calculate new amounts
      zutatenCopy = zutatenCopy.map((sublist) {
        if (sublist[0].isNotEmpty) {
          int number = int.tryParse(sublist[0]) ?? 0;
          sublist[0] = (number * multiplier).toString();
        }
        return sublist;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: GestureDetector(
                  onTap: () {
                    // TODO: go back to the page we were before
                    setState(() {});
                  },
                  child: Icon(CupertinoIcons.arrow_left)
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
                        "F", // Initialien
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
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(
                  top: 8,
                  right: 20,
                  left: 20,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect( // Ausnahme für bilder!! clipROUNDEDrect notwendig
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'lib/assets/images/nudeln_mit_walnuessen.png',
                                fit: BoxFit.cover,
                                height: 250,
                                // width: 150,
                              ),
                            ),
                          )
                        ],
                      ),
                      // TITLE & +/heart ICONS
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Nudeln mit Walnüssen',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 24,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Row(
                              children: [
                                Icon(CupertinoIcons.add_circled, size: 32),
                                SizedBox(width: 6), // Add some space between the icons if needed
                                Icon(CupertinoIcons.heart, size: 32, ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // TAGS
                      Container(
                        // width: 190,
                        height: 24,
                        // color: Theme.of(context).colorScheme.primary,
                        margin: const EdgeInsets.only(top: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 24,
                              margin: const EdgeInsets.only(right: 4),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onSecondary,
                                borderRadius: BorderRadius.circular(1000),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 12, left: 12),
                                child: Text(
                                  "vegan",
                                  style:Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                height: 24,
                                margin: const EdgeInsets.only(right: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1000),
                                  border: Border.all(color: Colors.black, width: 1),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.only(right: 4, left: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.euro, size: 16),
                                      Icon(Icons.euro, size: 16),
                                      Icon(Icons.euro, size: 16),
                                    ],
                                  ),
                                )
                            ),
                            Container(
                              height: 24,
                              margin: const EdgeInsets.only(right: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1000),
                                border: Border.all(color: Colors.black, width: 1),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(right: 12, left: 12),
                                child: Icon(
                                  Icons.schedule,
                                  size: 16,
                                ),
                              ),
                            ),
                            Container(
                                height: 24,
                                margin: EdgeInsets.only(right: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1000),
                                  border: Border.all(color: Colors.black, width: 1),
                                ),
                                child: const Padding(
                                    padding: EdgeInsets.only(right: 12, left: 12),
                                    child: Row(
                                      //crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.water_drop_outlined,
                                          size: 16,
                                        ),
                                        Icon(
                                          Icons.water_drop_outlined,
                                          size: 16,
                                        ),
                                      ],
                                    )
                                )
                            )
                          ],
                        ),
                      ),
                      // DESCRIPTION
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        child: Text(
                          'Der frische und gesunde Klassiker für den schnellen Genuss lorem impsum lorem ipsum frische und gesunde Klassiker für den schnellen Genuss lorem impsum lorem ipsum frische und gesunde Klassiker für den.',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      // ZUTATEN - Heading
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Zutaten',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 20,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Portionen',
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 20,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20), // Margin to the left
                                  width: 70, // Fixed width
                                  height: 32,
                                  child: TextField(
                                    controller: _controller, // definiert, was im textField steht
                                    focusNode: _focusNode,  // guckt, ob textfield fokus verliert, um auch _onSubmitted zu triggern
                                    onChanged: (String inputValue){
                                      inputDisplay = inputValue;
                                    },
                                    onSubmitted: _onSubmitted,

                                    cursorColor: Colors.black,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      hintText: '...',
                                      hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        fontSize: 18,
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(999), // Rounded corners
                                        borderSide: BorderSide(color: Colors.black, width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(999),
                                        borderSide: BorderSide(color: Colors.black, width: 1),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(999),
                                        borderSide: BorderSide(color: Colors.black, width: 1),
                                      ),
                                    ),
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontSize: 18,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      // ZUTATEN - Content
                      Container(
                        margin: const EdgeInsets.only(top: 6),
                        child: ZutatenList(
                          zutaten: zutatenCopy,
                        ),
                      ),
                      CustomButton(
                        // isDisabled: noZutatSelected, // LATER
                        onPressed: () {
                          if(!zutatenSelectable) {
                            zutatenSelectable = true;
                            buttonText = 'Ausgewählte hinzufügen';
                            zutatenWereAdded = false;
                          } else {
                            addSelectedToEinkaufsliste();
                            zutatenSelectable = false;
                            zutatenWereAdded = true;
                            buttonText = 'Erfolgreich hinzugefügt!';

                            // Set a timeout of 6 seconds
                            Future.delayed(Duration(seconds: 6), () {
                              if(!zutatenSelectable) {
                                zutatenWereAdded = false;
                                buttonText = 'Zur Einkaufsliste hinzufügen';
                                setState(() {});
                              }
                            });
                          }
                          setState(() {});
                        },
                      ),
                      // ZUBEREITUNG - Heading
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: Text(
                          'Zubereitung',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 20,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // ZUBEREITUNG - Content
                      Container(
                        margin: const EdgeInsets.only(top: 6),
                        child: const OrderedList(
                          items: [
                            'Lass das Mehl mit Wasser quellen und dann 2h stehen.',
                            'Kratze das Innere aus der Zucchini und mische es mit dem Käse und dem Hackfleisch.',
                            'Die gefüllte Zucchini muss bei 200°C für 35 Minuten gebacken werden.'
                          ],
                        ),
                      )
                    ]
                ),
              ),
            )
        )
    );
  }

  void addSelectedToEinkaufsliste() async {
    final List<String> einkaufsliste = prefs.getStringList('SavedList') ?? [];
    for(int i = 0; i < isZutatSelected.length; i++) {
      if(isZutatSelected[i]) {
        List<String> itemArray = zutatenCopy[i];
        // create item (immer "nicht gekauft")
        String item = itemArray[2] + ', ' + itemArray[0] + itemArray[1] + ', ' + 'Nicht gekauft';
        einkaufsliste.add(item);
        prefs.setStringList("SavedList", einkaufsliste);
      }
    }
  }
}


// helper for zutaten List
class ZutatenList extends StatefulWidget {
  const ZutatenList({super.key, required this.zutaten});
  final List<List<String>> zutaten;

  @override
  State<ZutatenList> createState() => _ZutatenListState();
}

class _ZutatenListState extends State<ZutatenList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isZutatSelected = List.generate(widget.zutaten.length, (index) {
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      child: zutatenSelectable ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(widget.zutaten.length, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: GestureDetector(
              onTap: () {
                isZutatSelected[index] = !isZutatSelected[index];
                setState(() {});
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, top: 3.0),
                    child: Container( // kreis zum auswählen des produkts
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          )
                      ),
                      child: Center(
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: isZutatSelected[index] ? Color(0xFFF5DC51) : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      '${widget.zutaten[index][0]} ${widget.zutaten[index][1]}',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.zutaten[index][2],
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      )
          :
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(widget.zutaten.length, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    '${widget.zutaten[index][0]} ${widget.zutaten[index][1]}',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.zutaten[index][2],
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}


// helper for button
class CustomButton extends StatefulWidget {
  final VoidCallback onPressed;
  // bool isDisabled; // LATER
  // CustomButton({super.key, required this.onPressed, required this.isDisabled});
  CustomButton({super.key, required this.onPressed});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  // bool _isHovered = false;
  bool _isPressed = false;
  // bool _isDisabled = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        widget.onPressed();
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: double.infinity,
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: _isPressed ? Color(0xFFD9C843) : Color(0xFFF5DC51),
          // widget.isDisabled ? Color.fromARGB(255, 200, 200, 200) : // LATER!!
          // (_isPressed ? Color(0xFFD9C843) : Color(0xFFF5DC51)),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300), // Duration of the transition
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: Row(
                key: ValueKey<String>(buttonText), // Key helps AnimatedSwitcher identify changes
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    buttonText,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if(!zutatenWereAdded) Container(
                    margin: EdgeInsets.only(left: 6),
                    child: Icon(CupertinoIcons.arrow_right)
                  )
                  else Container(
                    margin: EdgeInsets.only(left: 6),
                    child: Icon(CupertinoIcons.check_mark_circled)
                  )
                ]
              ),
            )
          ),
        ),
      ),
    );
  }
}

// helper for ordered List - zubereitung
class OrderedList extends StatelessWidget {
  final List<String> items;

  const OrderedList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(items.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${index + 1}. ',
                style: TextStyle(fontSize: 18),
              ),
              Expanded(
                child: Text(
                  items[index],
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}