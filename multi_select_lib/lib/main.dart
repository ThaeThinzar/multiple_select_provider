import 'package:flutter/material.dart';
import 'package:multi_select_lib/provider/list_provider.dart';
import 'package:multi_select_lib/provider/search_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => SearchProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'title',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primaryColor: Colors.blueAccent,
          ),
          home: const MyHomePage(
            title: 'Search',
          ),
        ),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<SearchModel> fileTypes = [
    SearchModel('Google Doc', Colors.white),
    SearchModel('Google Sheet', Colors.white),
    SearchModel('Google Slide', Colors.white),
    SearchModel('Google Form', Colors.white),
    SearchModel('Google Drawing', Colors.white),
  ];
  List<String> searchTypes = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) async {
        Provider.of<SearchProvider>(context, listen: false)
            .setSearchTypes(fileTypes);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SearchProvider searchProvider =
        Provider.of<SearchProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        height: 50,
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: searchProvider.searchTypes.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Provider.of<SearchProvider>(context, listen: false)
                      .updateSearchTypesToList(
                          SearchModel(
                              searchProvider.searchTypes[index].name,
                              searchProvider.searchTypes[index].color ==
                                      Colors.white
                                  ? Colors.blue
                                  : Colors.white),
                          index);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                      color: searchProvider.searchTypes[index].color,
                      border: Border.all(color: Colors.black),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: Text(
                      context.watch<SearchProvider>().searchTypes[index].name),
                ),
              );
            }),
      ),
    );
  }
}
