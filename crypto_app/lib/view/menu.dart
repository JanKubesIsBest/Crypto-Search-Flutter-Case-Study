import 'package:crypto_app/view/pages/page.dart';
import 'package:crypto_app/view/row/rowForLists.dart';
import 'package:crypto_app/view/search_query/searchQuery.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String searchedCrypto = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).colorScheme.background,
              centerTitle: true,
              pinned: true,
              floating: true,
              snap: false,
              elevation: 5,
              title: Text(widget.title),
              bottom: AppBar(
                title: TextField(
                  decoration: const InputDecoration()
                      .applyDefaults(Theme.of(context).inputDecorationTheme)
                      .copyWith(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        hintText: 'Search cryptos...',
                        isCollapsed: true,
                      ),
                  onChanged: (value) {
                    setState(() {
                      searchedCrypto = value;
                    });
                  },
                ),
              ),
            )
          ];
        },
        body: searchedCrypto.isNotEmpty
            ? SearchQuery(
                searchedCrypto: searchedCrypto,
              )
            : Column(
                children: [
                  const RowForLists(),
                  Expanded(
                    child: PageView(
                      children: const [
                        MyPage(),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
