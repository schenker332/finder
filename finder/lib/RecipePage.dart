import 'package:flutter/material.dart';
// import 'food_card.dart';
import 'package:flutter/cupertino.dart';
// import 'package:foodfinder_app/data.dart';

import 'package:foodfinder_app/data.dart';

class RecipePage extends StatefulWidget {
  List<List<String>> zutaten;

  RecipePage({super.key, required this.zutaten});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  List<List<String>> zutatenCopy = [[]];
  String inputDisplay = '1';
  TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // copy the zutaten that were handed to this widget (deep clone!)
    zutatenCopy = widget.zutaten.map((innerList) => List<String>.from(innerList)).toList();

    // init controller to display number correctly and event to handle focus loss of textfield
    _controller = TextEditingController(text: inputDisplay);
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // Trigger the onSubmitted event when the TextField loses focus
        _onSubmitted(_controller.text);
      }
    });
  }

  // handles updating zutatenCopy (doesnt change initial values, just copy)
  void _onSubmitted(String inputValue) {
    setState(() {
      int multiplier = int.tryParse(inputValue) ?? 1;
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
              title: const Icon(CupertinoIcons.arrow_left),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 8,
                    bottom: 8,
                  ),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(36),
                      color: Colors.black,
                    ),
                    child: Center(
                      child: Text(
                        currentUser.firstletter,
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
  Widget build(BuildContext context) {
    return Column(
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