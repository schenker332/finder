import 'package:flutter/material.dart';
import 'package:foodfinder_app/Data/card.dart';


class CardDesign extends StatelessWidget {
  final Cardbox card;

   const CardDesign({super.key, required this.card});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
          width: double.infinity,
          height: 132,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).colorScheme.primary,
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
          child:Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(15),
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
                        card.imageURL,
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
                          card.title,
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 18,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          width: 190,
                          height: 25,
                          color: Theme.of(context).colorScheme.primary,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 40,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.onSecondary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    card.foodart,
                                    style:Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontSize: 10,
                                      letterSpacing: 0,
                                    ),
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
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
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
                                  card.description,
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 10.5,
                                    letterSpacing: 0,
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
            ],
          ),
      ),
    );
  }
}
