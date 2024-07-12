import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Data/foodcard_storage.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController imageURLController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController foodartController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController waterneedController = TextEditingController();
  final FoodcardStorage storage = FoodcardStorage();
  final _Currentuser = ChatUser(id: "1", firstName: "Franziska");
  final ChatUser _gptChatUser = ChatUser(id: "2", firstName: "ChatGPT");
  final _chatGpt = OpenAI.instance.build(
    token: "...",
    baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
    enableLog: true,
  );
  List<ChatMessage> messages = [];

  //List<ChatUser> _typingUsers = <ChatUser>[];
  bool left = true;
  bool right = false;
  var selectedday;
  var selectedfoodart;
  var selectedprice;
  var selectedtime;
  var selectedwaterneed;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text(
                "Erstellen", // Username Nutzername
                style: Theme.of(context).textTheme.titleLarge!.copyWith(),
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
                              color: Colors.white,
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
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
                                child: Container(
                                  width: 124,
                                  height: 124,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 32),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          CupertinoIcons.add_circled,
                                          size: 40,
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        SizedBox(
                                          width: 140,
                                          height: 20,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 25, right: 25),
                                            child: TextFormField(
                                              controller: imageURLController,
                                              decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText: 'Bild hinzufügen',
                                                  labelStyle: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                  )),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )),
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
                                              )),
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
                                            padding: const EdgeInsets.only(left: 10),
                                            width: 150,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF5DC51),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: DropdownButton(

                                              focusColor: const Color(0xFFFFFBF9),
                                              dropdownColor: const Color(0xFFFFFBF9),
                                              underline: const SizedBox(),
                                              icon: const Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.black,
                                              ),
                                              hint: const Text(

                                                "An welchem Tag?",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              value: selectedday,
                                              items: [
                                                "Heute",
                                                "Morgen",
                                                "Montag",
                                                "Dienstag",
                                                "Mittwoch",
                                                "Donnerstag",
                                                "Freitag",
                                                "Samstag",
                                                "Sonntag"
                                              ]
                                                  .map((e) => DropdownMenuItem(
                                                        value: e,
                                                        child: Text("$e"),
                                                      ))
                                                  .toList(),
                                              onChanged: (val) {
                                                setState(() {
                                                  selectedday = val;
                                                });

                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(left: 10),
                                            width: 150,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF5DC51),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: DropdownButton(
                                              focusColor: const Color(0xFFFFFBF9),
                                              dropdownColor: const Color(0xFFFFFBF9),
                                              underline: const SizedBox(),
                                              icon: const Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.black,
                                              ),
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
                                                "Mit Fleich",
                                                "Vegetarisch",
                                              ]
                                                  .map((e) => DropdownMenuItem(
                                                        value: e,
                                                        child: Text("$e"),
                                                      ))
                                                  .toList(),
                                              onChanged: (val1) {
                                                setState(() {
                                                  selectedfoodart = val1;
                                                });
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(left: 10),
                                            width: 150,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF5DC51),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: DropdownButton(
                                              focusColor: const Color(0xFFFFFBF9),
                                              dropdownColor: const Color(0xFFFFFBF9),
                                              underline: const SizedBox(),
                                              icon: const Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.black,
                                              ),
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
                                              ]
                                                  .map((e) => DropdownMenuItem(
                                                        value: e,
                                                        child: Text("$e "),
                                                      ))
                                                  .toList(),
                                              onChanged: (val2) {
                                                setState(() {
                                                  selectedprice = val2;
                                                });
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(left: 10),
                                            width: 150,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF5DC51),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: DropdownButton(
                                              focusColor: const Color(0xFFFFFBF9),
                                              dropdownColor: const Color(0xFFFFFBF9),
                                              underline: const SizedBox(),
                                              icon: const Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.black,
                                              ),
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
                                              ]
                                                  .map((e) => DropdownMenuItem(
                                                        value: e,
                                                        child: Text("$e"),
                                                      ))
                                                  .toList(),
                                              onChanged: (val3) {
                                                setState(() {
                                                  selectedtime = val3;
                                                });
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(left: 10),
                                            width: 150,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF5DC51),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: DropdownButton(
                                              focusColor: const Color(0xFFFFFBF9),
                                              dropdownColor: const Color(0xFFFFFBF9),
                                              underline: const SizedBox(),
                                              icon: const Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.black,
                                              ),
                                              hint: const Text(
                                                "Wasserverbrauch",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              value: selectedwaterneed,
                                                items: []
                                                  .map((e) => DropdownMenuItem(
                                                        value: e,
                                                        child: Text("$e"),
                                                      ))
                                                  .toList(),
                                              onChanged: (val4) {
                                                setState(() {
                                                  selectedwaterneed = val4;
                                                });
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ))
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
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
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
                              border:
                              Border.all(color: Colors.black, width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: TextFormField(
                              controller: descriptionController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Beschreib das Rezept',
                                  labelStyle: TextStyle(
                                      color: Colors.grey, fontSize: 16)),
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
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
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
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Container(
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
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Zutat',
                                        labelStyle: TextStyle(
                                            color: Colors.grey, fontSize: 14)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Container(
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
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Menge',
                                        labelStyle: TextStyle(
                                            color: Colors.grey, fontSize: 14)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Container(
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
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Stk.',
                                        labelStyle: TextStyle(
                                            color: Colors.grey, fontSize: 14)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Container(
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
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Zutat',
                                        labelStyle: TextStyle(
                                            color: Colors.grey, fontSize: 14)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Container(
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
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Menge',
                                        labelStyle: TextStyle(
                                            color: Colors.grey, fontSize: 14)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Container(
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
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Stk.',
                                        labelStyle: TextStyle(
                                            color: Colors.grey, fontSize: 14)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Container(
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
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Zutat',
                                        labelStyle: TextStyle(
                                            color: Colors.grey, fontSize: 14)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Container(
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
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Menge',
                                        labelStyle: TextStyle(
                                            color: Colors.grey, fontSize: 14)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Container(
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
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Stk.',
                                        labelStyle: TextStyle(
                                            color: Colors.grey, fontSize: 14)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 150,
                        child: Positioned(
                          right: 200,
                          child: MaterialButton(
                            onPressed: () {},
                            color: const Color(0xFFF5DC51),
                            minWidth: 150,
                            height: 30,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: const Row(
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
                                )
                              ],
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
                            "Zubereitung",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
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
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Was ist zu tun?',
                                  labelStyle: TextStyle(
                                      color: Colors.grey, fontSize: 16)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 100,
                        child: Positioned(
                          right: 200,
                          child: MaterialButton(
                            onPressed: () {},
                            color: const Color(0xFFF5DC51),
                            minWidth: 150,
                            height: 30,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: const Text(
                              "Speichern",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //KI_Page
                DashChat(
                  messages: messages,
                  messageOptions: const MessageOptions(
                    currentUserContainerColor: Color(0xFFCFD8CD),
                    containerColor: Color.fromRGBO(0, 166, 126, 1),
                    textColor: Colors.black,
                    currentUserTextColor: Colors.black,
                  ),
                  onSend: onSend,
                  currentUser: _Currentuser,
                )
              ],
            ),
          ),
        ));
  }


  void onSend(ChatMessage message) async {
    setState(() {
      messages.insert(0, message);
    });
    List<Map<String, dynamic>> messagesHistory =
        messages.reversed.map((message) {
      if (message.user == _Currentuser) {
        return {"role": "user", "content": message.text};
      } else {
        return {"role": "assistant", "content": message.text};
      }
    }).toList();
    var request = ChatCompleteText(
        model: Gpt4ChatModel(),
        messages: messagesHistory,
        maxToken: 200);
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
                text: element.message!.content));
      });
    }
  }
}
/*
  Future<void>getChatResponse(ChatMessage m) async {
    setState(() {
      _messages.insert(0, m);
      _typingUsers.add(_gptChatUser);
    });
    var messages;
    List<Map<String, dynamic>> _messagesHistory = messages.reversed.map((m){
      if (m.user == _Currentuser){
        return Messages(role: Role.user, content:m.text);
      } else{return Messages(role: Role.assistant, content:m.text);}
    }).toList();
    final request = ChatCompleteText(model: GptTurbo0301ChatModel(), messages: _messagesHistory, maxToken: 200);
    final response = await _openAI.onChatCompletion(request: request);
    for (var element in response!.choices){
      setState(() {
        _messages.insert(0, ChatMessage(user: _gptChatUser, createdAt: DateTime.now(), text: element.message!.content));
      });
    }
    setState(() {
      _typingUsers.remove(_gptChatUser);
    });
  }
}
*/

/*
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 50, left: 20, right: 20 ),
                      alignment: Alignment.center,
                      child: Text(
                        "Lassen Sie sich von unserem intelligenten Assistenten inspirieren und erstellen Sie innerhalb von Sekunden das perfekte Rezept für jedn Anlass!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: 300,
                      height: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          "https://th.bing.com/th/id/OIP.bciqySzv3orDFP18wQ1YsQHaE8?rs=1&pid=ImgDetMain", // MODIFIED
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: double.infinity,
                        height: 90,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.black, width: 1)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Welche Zutaten hast Du noch...',
                                labelStyle: TextStyle(
                                    color: Colors.grey, fontSize: 16)),
                          ),
                        ),
                      ),
                    ),
                  ],
                )

                 */
/*
      appBar: AppBar(
        title: Text(
          "Erstellen", // Username Nutzername
          style: Theme.of(context).textTheme.titleLarge!.copyWith(),
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
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                if (left == false) {
                  left = true;
                  right = false;
                }
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 100),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: left == true ? Colors.black : Colors.grey,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Text(
                    "Mein Rezept",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 20,
                          letterSpacing: 0,
                          color: left == true ? Colors.black : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (right == false) {
                  right = true;
                  left = false;
                }
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 100),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: right == true ? Colors.black : Colors.grey,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Text(
                    "KI Rezept",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 20,
                          letterSpacing: 0,
                          color: right == true ? Colors.black : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    width: 124,
                    height: 124,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(CupertinoIcons.add_circled, size: 40,),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: 140,
                            height: 20,
                            child: Container(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, right: 25),
                                child: TextFormField(
                                  controller: imageURLController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Bild hinzufügen',
                                      labelStyle: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      )),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: "Titel",
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              controller: descriptionController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Mein tolles Essen...',
                                  labelStyle: TextStyle(color: Colors.grey)),
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(CupertinoIcons.add_circled),
                              Text(
                                "Tags",
                              ),
                            ],
                          ))
                    ],
                  ))
            ],
          ),
        ),
        */

/*
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(


              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: imageURLController,
                  decoration: InputDecoration(labelText: 'Image URL'),
                ),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                ),
                TextField(
                  controller: foodartController,
                  decoration: InputDecoration(labelText: 'Food Art'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: timeController,
                  decoration: InputDecoration(labelText: 'Time'),
                ),
                TextField(
                  controller: waterneedController,
                  decoration: InputDecoration(labelText: 'Water Need'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveFoodcard,
                  child: Text("Save"),
                ),
              ],

            ),
          ),
        ),

         */
/*]),*/
