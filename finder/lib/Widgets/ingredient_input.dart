import 'package:flutter/material.dart';

typedef VoidCallback = void Function();

class IngredientInput extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController mengeController;
  final TextEditingController einheitController;

  const IngredientInput({super.key, required this.nameController, required this.mengeController, required this.einheitController});

  @override
  State<IngredientInput> createState() => _IngredientInputState();
}

class _IngredientInputState extends State<IngredientInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                width: double.infinity,
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
                    controller: widget.nameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Zutat',
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
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                width: double.infinity,
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
                    controller: widget.mengeController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Menge',
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
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                width: double.infinity,
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
                    controller: widget.einheitController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Einheit',
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
          ),
        ],
      ),
    );
  }
}
