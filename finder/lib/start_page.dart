import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class StartPage extends StatelessWidget {
  String Name_Food;
  String Art_Food;

  StartPage({
    super.key,
    required this.Name_Food,
    required this.Art_Food,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: 345,
            height: 41,
            child: Row(
              children: [
                Text(
                  "Hallo Franz!",
                  style: TextStyle(
                    fontSize: 30,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 128,
                  ),
                  child: Container(
                    width: 36,
                    height: 36,
                    child: Center(
                      child: Icon(
                        Icons.circle,
                        size: 36,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
              child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Container(
                width: 345,
                height: 41,
                child: Row(
                  children: [
                    Text(
                      "Wochenplan",
                      style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 190,
                      ),
                      child: Container(
                        width: 36,
                        height: 36,
                        child: Center(
                          child: Icon(
                            Icons.arrow_forward,
                            size: 32,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: 352,
              height: 132,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              child: Row(children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          "https://media.istockphoto.com/id/1680097339/de/foto/rigatoni-nudeln-in-basilikum-pesto-w%C3%BCrzige-italienische-pasta.jpg?s=1024x1024&w=is&k=20&c=4h6c_m9Tv54mMwExNJ4XhzQUBnzglXhIUUnLa8BH8Og=",
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      child: Column(
                        children: [
                          Text(
                            Name_Food,
                            style: const TextStyle(
                              fontSize: 14,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            width: 190,
                            height: 25,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 40,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      Art_Food,
                                      style: const TextStyle(fontSize: 8),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.euro, size: 10),
                                      Icon(Icons.euro, size: 10),
                                      Icon(Icons.euro, size: 10),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 30,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.schedule,
                                      size: 10,
                                    ),
                                  ),
                                ),
                                Container(
                                    width: 40,
                                    height: 15,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.black, width: 1),
                                    ),
                                    child: Row(
                                      //crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.water_drop_outlined,
                                          size: 10,
                                        ),
                                        Icon(
                                          Icons.water_drop_outlined,
                                          size: 10,
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                          Container(
                              width: 190,
                              height: 45,
                              //color: Colors.cyan,
                              child: Column(
                                children: [
                                  Text(
                                    "Der frische und gesunde Klassiker für den schnellen Genuss lorem impsum lorem ipsum",
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                      padding: const EdgeInsets.only(
                        top: 70,
                        right: 20,
                      ),
                      child: Container(
                        width: 40,
                        height: 15,
                        child: Icon(
                          Icons.favorite,
                          size: 20,
                        ),
                      )),
                ),
              ]),
            ),
          ]))
        ],
      ),
    );
  }
}
