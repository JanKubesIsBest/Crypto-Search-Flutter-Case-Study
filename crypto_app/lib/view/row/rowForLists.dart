import 'package:flutter/material.dart';

class RowForLists extends StatelessWidget {
  const RowForLists({super.key});

  // TODO: This will change completely, design, functions etc..
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () => print("HI"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(50, 123, 123, 123),
              shadowColor: Colors.transparent,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6)
              )
            ),
            child: const Text("Trending", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),),
          )
        ],
      ),
    );
  }
}
