import 'package:crypto_app/view/pages/page.dart';
import 'package:crypto_app/view/row/rowForLists.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget{
  final String title;
  
  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: 
      Column(children: [
        const RowForLists(),
        Expanded(
          child: PageView(children: const [
            MyPage(),
          ]),
        ),
      ],)
    );
  }
}
