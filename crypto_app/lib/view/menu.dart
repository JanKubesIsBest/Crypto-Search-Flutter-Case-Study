import 'package:crypto_app/model/List.dart';
import 'package:crypto_app/model/database/open_database.dart';
import 'package:crypto_app/model/database/retrieve.dart';
import 'package:crypto_app/view/pages/page.dart';
import 'package:crypto_app/view/row/rowForLists.dart';
import 'package:crypto_app/view/search_query/modal/modal_for_lists.dart';
import 'package:crypto_app/view/search_query/searchQuery.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

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
              : PageViewBuilderForList()),
    );
  }
}

class PageViewBuilderForList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageViewBuilderForListState();
}

class _PageViewBuilderForListState extends State<PageViewBuilderForList> {
  late Future<List<MyList>> lists;

  Future<List<MyList>> getListsWithDb() async {
    final Database db = await openMyDatabase();

    return await getLists(db, false);
  }

  @override
  void initState() {
    super.initState();
    lists = getListsWithDb();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MyList>>(
        future: lists,
        builder: (BuildContext context, AsyncSnapshot<List<MyList>> snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return Column(
              children: [
                const RowForLists(),
                Expanded(
                  child: PageView.builder(
                    // Trending is included in the list as the first one
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return MyPage(
                        // Trending id is 1
                        index: index + 1,
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },);
  }
}
