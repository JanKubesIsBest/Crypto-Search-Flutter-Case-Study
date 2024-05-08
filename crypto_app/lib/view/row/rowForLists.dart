import 'package:crypto_app/model/List.dart';
import 'package:crypto_app/view/menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RowForLists extends StatelessWidget {
  final List<MyList> lists;
  final PageController controller;

  const RowForLists({super.key, required this.lists, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: lists.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Sadly, I don't have time to implement the animating feature.
                  controller.jumpToPage(index,);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Provider.of<CurrentPageProvider>(context).currentPage == index ? const Color.fromARGB(48, 20, 164, 4) : const Color.fromARGB(50, 123, 123, 123),
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6))),
                  child: Text(
                    lists[index].name,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400,
                      ),
                ),
              ),
            );
          },
        ),
    );
  }
}
