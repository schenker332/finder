import 'package:flutter/material.dart';

class FirstElement extends StatelessWidget {
  const FirstElement({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 150,
      padding: EdgeInsets.only(
        top: 15,
        bottom: 15,
        right: 15,
        left: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.black,
          width: 1.5,
      )
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network("https://media.istockphoto.com/id/1316913768/de/foto/pasta-spaghetti-mit-pestosauce-und-frischen-basilikumbl%C3%A4ttern.jpg?s=612x612&w=is&k=20&c=xg7Ubl32s1s4uW9_arBN3psXQXiK8JdAHDx3lvhTawg=",
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nudeln mit Walnüssen",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 17,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "vegan",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,

                            ),
                          ),
                        )
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
  );
  }
}
