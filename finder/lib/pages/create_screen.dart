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
  List<IngredientInput> ingredients = [];

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
            title: Text(
              "Erstellen",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(),
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
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () async{
                                final ImagePicker picker = ImagePicker();
                                XFile? file = await picker.pickImage(source: ImageSource.gallery);
                                if(file != null){
                                  imagePath = file.path;
                                  setState(() {

                                  });
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
                                  child: imagePath.isEmpty ? const Icon(
                                    CupertinoIcons.add_circled,
                                    size: 40,
                                  ) : const SizedBox(),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            flex: 3,
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
                                  width: double.infinity,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: TextFormField(
                                      controller: titleController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Mein tolles Essen...',
                                        labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
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
                                          hint: const Text(
                                            "Art des Essen",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                          value: selectedfoodart,
                                          items: [
                                            "Vegan",
                                            "Fleisch",
                                            "Veggie",
                                          ].map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text("$e"),
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
                                          hint: const Text(
                                            "Preis Hinzufügen",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                          value: selectedprice,
                                          items: [
                                            "€",
                                            "€€",
                                            "€€€",
                                          ].map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text("$e "),
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
                                          hint: const Text(
                                            "Zeit Hinzufügen",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                          value: selectedtime,
                                          items: [
                                            "kurz",
                                            "lang",
                                            "sehr lang",
                                          ].map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text("$e"),
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
                                          hint: const Text(
                                            "Wasserverbrauch",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                          value: selectedwaterneed,
                                          items: [
                                            "wenig",
                                            "mittel",
                                            "viel"
                                          ].map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text("$e"),
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
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            controller: descriptionController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Beschreib das Rezept',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
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
                    GestureDetector(
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
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 25
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5DC51),
                          borderRadius: BorderRadius.circular(1000)
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_circle_outline,
                              size: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Zutat",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
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
                        width: double.infinity,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextField(
                            maxLines: 3,
                            controller: preparationController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Was ist zu tun?',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
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
                          "time": (["kurz", "lang", "sehr lang"].indexOf(selectedtime) + 1).toString(),
                          "waterneed": (["wenig", "mittel", "viel"].indexOf(selectedwaterneed) + 1).toString(),
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
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 25
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5DC51),
                          borderRadius: BorderRadius.circular(1000)
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Speichern",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
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
