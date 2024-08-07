import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'food_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodfinder_app/Data/foodcard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Data/foodcard_storage.dart';

// import 'package:foodfinder_app/data.dart';

// import 'package:foodfinder_app/data.dart';

bool zutatenSelectable = false;
bool zutatenWereAdded = false;
String buttonText = 'Zur Einkaufsliste hinzufügen';
// bool noZutatSelected = false; // LATER
List<bool> isZutatSelected = [];
List<List<String>> zutatenCopy = [[]];


class RecipePage extends StatefulWidget {
  Foodcard recipe;
  List<List<String>> zutaten;
  int portionen;

  RecipePage({super.key, required this.recipe, required this.zutaten, required this.portionen});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  String inputDisplay = '';
  TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  List<String> einkaufsliste = [];
  late SharedPreferences prefs;

  bool isLiked = false;

  @override
  void initState() {
    super.initState();

    // determine if this recipe is liked
    FoodcardStorage().getLikedRecipeIds().then((List<String> likedIds){
      if(likedIds.contains(widget.recipe.id)){
        setState(() {
          isLiked = true;
        });
      }
    });

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
          int number = int.tryParse(sublist[0]) ?? -1;
          if(number != -1) sublist[0] = (number * multiplier).toString();
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
              scrolledUnderElevation: 0.0,
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
                              child: widget.recipe.imageURL.isEmpty ?
                                SizedBox() :
                                (widget.recipe.imageURL.contains("assets") ?
                                  Image.asset(
                                    widget.recipe.imageURL,
                                    fit: BoxFit.cover,
                                    height: 250,
                                    // width: 150,
                                  ) : (kIsWeb ?
                                    SizedBox() : Image.file(
                                      File(widget.recipe.imageURL), // MODIFIED
                                      width: double.infinity,
                                      height: 250,
                                      fit: BoxFit.cover,
                                    )
                                  )
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
                            Expanded(
                              child: Text(
                                widget.recipe.title,
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 28,
                                  letterSpacing: 0.3,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                // Icon(CupertinoIcons.add_circled, size: 32),
                                // SizedBox(width: 6), // Add some space between the icons if needed
                                GestureDetector(
                                  onTap: (){
                                    isLiked = !isLiked;

                                    if(isLiked){
                                      FoodcardStorage().likeRecipe(widget.recipe.id);
                                    } else {
                                      FoodcardStorage().unlikeRecipe(widget.recipe.id);
                                    }

                                    setState(() {});
                                  },
                                  child: AnimatedSwitcher(
                                    duration: Duration(milliseconds: 200),
                                    transitionBuilder: (Widget child, Animation<double> animation) {
                                      final curvedAnimation = CurvedAnimation(
                                        parent: animation,
                                        curve: Curves.easeOut,
                                      );
                                      return ScaleTransition(
                                        scale: curvedAnimation,
                                        child: child,
                                      );
                                    },
                                    child: Icon(
                                      isLiked ? Icons.favorite : Icons.favorite_border,
                                      key: ValueKey<bool>(isLiked),
                                      size: 32,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // TAGS
                      Container(
                        height: 24,
                        margin: const EdgeInsets.only(top: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 24,
                              padding: EdgeInsets.symmetric(vertical: 2),
                              margin: const EdgeInsets.only(right: 4),
                              decoration: BoxDecoration(
                                color: widget.recipe.foodart == "Fleisch" ? Theme.of(context).colorScheme.secondary : widget.recipe.foodart == "Veggie" ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSecondary,
                                borderRadius: BorderRadius.circular(1000),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  widget.recipe.foodart,
                                  style:Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                    color: Colors.black
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                height: 24,
                                margin: const EdgeInsets.only(right: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(1000),
                                  border: Border.all(color: Colors.black, width: 1),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: int.parse(widget.recipe.price) == 1 ? 10 : 8,
                                      vertical: 3
                                  ),
                                  child: Wrap(
                                    spacing: -1.0,
                                    children: List.generate(int.parse(widget.recipe.price), (int index){
                                      return const Icon(Icons.euro, size: 16);
                                    }),
                                  ),
                                )
                            ),
                            Container(
                              height: 24,
                              margin: const EdgeInsets.only(right: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(1000),
                                border: Border.all(color: Colors.black, width: 1),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: int.parse(widget.recipe.time) == 1 ? 10 : 8,
                                    vertical: 3
                                ),
                                child: Wrap(
                                  spacing: -1,
                                  children: List.generate(int.parse(widget.recipe.time), (int index){
                                    return const Icon(Icons.schedule, size: 16);
                                  }),
                                ),
                              ),
                            ),
                            Container(
                                height: 24,
                                margin: EdgeInsets.only(right: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(1000),
                                  border: Border.all(color: Colors.black, width: 1),
                                ),
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: int.parse(widget.recipe.waterneed) == 1 ? 10 : 8,
                                        vertical: 3
                                    ),
                                    child: Wrap(
                                      spacing: -3,
                                      children: List.generate(int.parse(widget.recipe.waterneed), (int index){
                                        return const Icon(Icons.water_drop_outlined, size: 16);
                                      }),
                                    )
                                )
                            )
                          ],
                        ),
                      ),
                      // DESCRIPTION
                      Container(
                        margin: const EdgeInsets.only(top: 12, bottom: 12),
                        child: Text(
                          widget.recipe.description,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            height: 1.3
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
                                fontSize: 22,
                                letterSpacing: 0.3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Portionen',
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 22,
                                    letterSpacing: 0.3,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20), // Margin to the left
                                  width: 70, // Fixed width
                                  height: 32,
                                  color: Colors.white,
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
                        padding: const EdgeInsets.only(top: 34),
                        child: Text(
                          'Zubereitung',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 22,
                            letterSpacing: 0.3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // ZUBEREITUNG - Content
                      Container(
                        margin: const EdgeInsets.only(top: 6, bottom: 85),
                        child: OrderedList(
                          items: widget.recipe.preparation
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
            padding: const EdgeInsets.symmetric(vertical: 1.0),
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
            padding: const EdgeInsets.symmetric(vertical: 1.0),
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
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
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
          ),
        );
      }),
    );
  }
}