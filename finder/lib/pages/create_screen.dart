import 'dart:convert';
import 'dart:io';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Data/foodcard_storage.dart';
import '../Data/SharedPreferencesHelper.dart';
import '../Widgets/ingredient_input.dart';  // Import the helper

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController imageURLController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController preparationController = TextEditingController();
  final FoodcardStorage storage = FoodcardStorage();
  final _Currentuser = ChatUser(id: "1", firstName: "Franziska");
  final ChatUser _gptChatUser = ChatUser(id: "2", firstName: "ChatGPT");
  final _chatGpt = OpenAI.instance.build(
    token: "[TOKEN]",
    baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
    enableLog: true,
  );
  List<ChatMessage> messages = [];

  bool left = true;
  bool right = false;
  var selectedday;
  var selectedfoodart;
  var selectedprice;
  var selectedtime;
  var selectedwaterneed;
  String imagePath = "";
  List<IngredientInput> ingredients = [IngredientInput(
    nameController: TextEditingController(),
    mengeController: TextEditingController(),
    einheitController: TextEditingController(),
  )];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Padding(
              padding: EdgeInsets.only(left: 8, top: 18, bottom: 12),
              child: Text(
                "Erstellen",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(),
              ),
            ),
            bottom: TabBar(
              indicatorColor: Colors.black,
              indicatorWeight: 2,
              dividerColor: const Color(0xFFFFFBF9),
              tabs: [
                Tab(
                  child: Text(
                    "Mein Rezept",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 20,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "KI Rezept",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 20,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            flex: 3,
                            child: GestureDetector(
                              onTap: () async{
                                final ImagePicker picker = ImagePicker();
                                XFile? file = await picker.pickImage(source: ImageSource.gallery);
                                if(file != null){
                                  imagePath = file.path;
                                  setState(() {});
                                }
                              },
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    image: imagePath.isNotEmpty ? DecorationImage(
                                      image: FileImage(File(imagePath)),
                                      fit: BoxFit.cover
                                    ) : null
                                  ),
                                  child: imagePath.isEmpty ? Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          CupertinoIcons.add_circled,
                                          size: 40,
                                        ),
                                        Text(
                                          "Bild hinzufügen",
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            color: Colors.grey,
                                            fontSize: 16
                                          ),
                                        )
                                      ],
                                    ),
                                  ) : const SizedBox(),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            flex: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 40,
                                  child: Text(
                                    "Titel",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: TextField(
                                      controller: titleController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Mein tolles Essen...',
                                        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          fontSize: 20,
                                          color: Colors.grey,
                                        )
                                      ),
                                      cursorColor: Colors.black,
                                      cursorWidth: 1,
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(left: 10, top: 4, bottom: 4),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF5DC51),
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: DropdownButton(
                                          focusColor: const Color(0xFFFFFBF9),
                                          dropdownColor: const Color(0xFFFFFBF9),
                                          underline: const SizedBox(),
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.black,
                                          ),
                                          isDense: true,
                                          hint: Text(
                                            "Essen ist...",
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.4,
                                              color: Colors.black,
                                            )
                                          ),
                                          value: selectedfoodart,
                                          items: [
                                            "Vegan",
                                            "Veggie",
                                            "Fleisch",
                                          ].map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              e,
                                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.4,
                                                color: Colors.black,
                                              )
                                            ),

                                          )).toList(),
                                          onChanged: (val1) {
                                            if(val1 != null){
                                              setState(() {
                                                selectedfoodart = val1;
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(left: 10, top: 4, bottom: 4),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF5DC51),
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: DropdownButton(
                                          focusColor: const Color(0xFFFFFBF9),
                                          dropdownColor: const Color(0xFFFFFBF9),
                                          underline: const SizedBox(),
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.black,
                                          ),
                                          isDense: true,
                                          hint: Text(
                                            "Kosten",
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.4,
                                              color: Colors.black,
                                            ),
                                          ),
                                          value: selectedprice,
                                          items: [
                                            "€",
                                            "€€",
                                            "€€€",
                                          ].map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              e,
                                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.4,
                                                color: Colors.black,
                                              )
                                            ),
                                          )).toList(),
                                          onChanged: (val2) {
                                            if(val2 != null){
                                              setState(() {
                                                selectedprice = val2;
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(left: 10, top: 4, bottom: 4),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF5DC51),
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: DropdownButton(
                                          focusColor: const Color(0xFFFFFBF9),
                                          dropdownColor: const Color(0xFFFFFBF9),
                                          underline: const SizedBox(),
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.black,
                                          ),
                                          isDense: true,
                                          hint: Text(
                                            "Dauer",
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.4,
                                              color: Colors.black,
                                            ),
                                          ),
                                          value: selectedtime,
                                          items: [
                                            "schnell",
                                            "mittel",
                                            "braucht Zeit",
                                          ].map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              e,
                                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.4,
                                                color: Colors.black,
                                              )
                                            ),
                                          )).toList(),
                                          onChanged: (val3) {
                                            if(val3 != null){
                                              setState(() {
                                                selectedtime = val3;
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(left: 10, top: 4, bottom: 4),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF5DC51),
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: DropdownButton(
                                          focusColor: const Color(0xFFFFFBF9),
                                          dropdownColor: const Color(0xFFFFFBF9),
                                          underline: const SizedBox(),
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.black,
                                          ),
                                          isDense: true,
                                          hint: Text(
                                            "Wasserverbrauch",
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.4,
                                              color: Colors.black,
                                            )
                                          ),
                                          value: selectedwaterneed,
                                          items: [
                                            "wenig Wasser",
                                            "normal",
                                            "viel Wasser"
                                          ].map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              e,
                                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.4,
                                                color: Colors.black,
                                              )
                                            ),
                                          )).toList(),
                                          onChanged: (val4) {
                                            if(val4 != null){
                                              setState(() {
                                                selectedwaterneed = val4;
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: SizedBox(
                        width: double.infinity,
                        height: 30,
                        child: Text(
                          "Beschreibung",
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 24,
                            letterSpacing: 0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.black, width: 1),
                          color: Colors.white
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          child: TextField(
                            controller: descriptionController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Beschreib das Rezept...',
                              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 16,
                                color: Colors.grey,
                              ),

                            ),
                            cursorColor: Colors.black,
                            cursorWidth: 1,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, top: 10),
                      child: SizedBox(
                        width: double.infinity,
                        height: 30,
                        child: Text(
                          "Zutaten",
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 24,
                            letterSpacing: 0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ...ingredients,
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  TextEditingController nameController = TextEditingController();
                                  TextEditingController mengeController = TextEditingController();
                                  TextEditingController einheitController = TextEditingController();

                                  ingredients.add(IngredientInput(
                                    nameController: nameController,
                                    mengeController: mengeController,
                                    einheitController: einheitController,
                                  ));
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                  right: 10
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF5DC51),
                                  borderRadius: BorderRadius.circular(1000)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_circle_outline,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Zutat",
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
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: SizedBox()
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, top: 10),
                      child: SizedBox(
                        width: double.infinity,
                        height: 30,
                        child: Text(
                          "Zubereitung",
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 24,
                            letterSpacing: 0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.black, width: 1),
                          color: Colors.white
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          child: TextField(
                            controller: preparationController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Trenne jeden Schritt mit einem Zeilenumbruch',
                              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            cursorColor: Colors.black,
                            cursorWidth: 1,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () async{
                        if(selectedprice == null || selectedfoodart == null || selectedtime == null || selectedwaterneed == null || imagePath.isEmpty){
                          return;
                        }

                        Map<String, dynamic> jsonData = {
                          "id": DateTime.now().millisecondsSinceEpoch.toString(),
                          "title": titleController.text,
                          "imageURL": imagePath,
                          "description": descriptionController.text,
                          "price": (["€", "€€", "€€€"].indexOf(selectedprice) + 1).toString(),
                          "foodart": selectedfoodart,
                          "time": (["schnell","mittel","braucht Zeit"].indexOf(selectedtime) + 1).toString(),
                          "waterneed": (["wenig Wasser","normal","viel Wasser"].indexOf(selectedwaterneed) + 1).toString(),
                          "portion": "4",
                          "ingredients": List.generate(ingredients.length, (int index){
                            return [
                              ingredients[index].mengeController.text,
                              ingredients[index].einheitController.text,
                              ingredients[index].nameController.text
                            ];
                          }),
                          "preparation": preparationController.text.split("\n"),
                          "Kommentar": "",
                          "tags": []
                        };

                        String recipeKey = "RECIPES";
                        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                        List<String> savedRecipes = sharedPreferences.getStringList(recipeKey) ?? [];
                        savedRecipes.add(jsonEncode(jsonData));
                        sharedPreferences.setStringList(recipeKey, savedRecipes);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 25
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF5DC51),
                                  borderRadius: BorderRadius.circular(1000)
                                ),
                                child: Text(
                                  "Speichern",
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.4,
                                    color: Colors.black,
                                  )
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 90,
                    )
                  ],
                ),
              ),
              //KI_Page
              Padding(
                padding: const EdgeInsets.only(bottom: 88.0),
                child: DashChat(
                  messages: messages,
                  inputOptions: InputOptions(
                    cursorStyle: const CursorStyle(
                      color: Colors.black,
                      width: 1,
                    ),
                    inputDecoration: InputDecoration(
                      fillColor: Colors.white,
                      hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 20,
                        letterSpacing: 0,
                        height: 1,
                        color: Colors.grey
                      ),
                      hintText: 'Schreib deinen Wunsch auf!',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(99.0)),
                          borderSide: BorderSide(color: Colors.black)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(99.0)),
                          borderSide: BorderSide(color: Colors.black)
                      ),
                    ),
                    inputTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 20,
                      letterSpacing: 0,
                      height: 1,
                    ),
                    alwaysShowSend: true,
                    sendOnEnter: true,
                    sendButtonBuilder: (fct) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(99),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 11.0, right: 9.0),
                            child: Icon(Icons.send),
                          ),
                        ),
                      );
                    }
                  ),
                  //scrollToBottomOptions: DefaultScrollToBottom(),
                  messageOptions: MessageOptions(
                    currentUserContainerColor: Theme.of(context).colorScheme.onPrimary,
                    containerColor: Colors.grey,
                    textColor: Colors.black,
                    currentUserTextColor: Colors.black,
                    showOtherUsersAvatar: false,
                    showOtherUsersName: false,
                  ),
                  onSend: onSend,
                  currentUser: _Currentuser,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSend(ChatMessage message) async {
    setState(() {
      messages.insert(0, message);
    });
    List<Map<String, dynamic>> messagesHistory = messages.reversed.map((message) {
      if (message.user == _Currentuser) {
        return {"role": "user", "content": message.text};
      } else {
        return {"role": "assistant", "content": message.text};
      }
    }).toList();
    var request = ChatCompleteText(
      model: Gpt4ChatModel(),
      messages: messagesHistory,
      maxToken: 200,
    );
    var response = await _chatGpt.onChatCompletion(request: request);
    print("RESPONSE:");
    print(response);
    for (var element in response!.choices) {
      setState(() {
        messages.insert(
          0,
          ChatMessage(
            user: _gptChatUser,
            createdAt: DateTime.now(),
            text: element.message!.content,
          ),
        );
      });
    }
  }
}
