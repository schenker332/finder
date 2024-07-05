import 'package:flutter/material.dart';
import 'package:foodfinder_app/Data/foodcard.dart';

class FoodcardDesign extends StatefulWidget {
  final Foodcard foodcard;
  const FoodcardDesign({super.key, required this.foodcard});

  @override
  _FoodcardDesignState createState() => _FoodcardDesignState();
}




class _FoodcardDesignState extends State<FoodcardDesign> {
  bool isLiked = false; // ADDED







  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: double.infinity,
        height: 132,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: Row(
          children: [
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
                      widget.foodcard.imageURL, // MODIFIED
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
                child: Column(
                  children: [
                    Text(
                      widget.foodcard.title, // MODIFIED
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                widget.foodcard.foodart, // MODIFIED
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                            child: const Row(
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
                            child: const Center(
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
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                            ),
                          ),


                        ],
                      ),
                    ),
                    SizedBox(
                      width: 190,
                      height: 45,
                      child: Column(
                        children: [
                          Text(
                            widget.foodcard.description, // MODIFIED
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 10.5,
                              letterSpacing: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: IconButton(
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked;
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
