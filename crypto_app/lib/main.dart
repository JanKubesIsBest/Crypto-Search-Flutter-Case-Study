import 'package:crypto_app/view/pages/page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Crypto'),
    );
  }
}

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
        const SizedBox(
          height: 100,
          child: Row(
            children: [],
          ),
        ),
        Expanded(
          child: PageView(children: [
            MyPage(),
          ]),
        ),
      ],)
    );
  }
}
