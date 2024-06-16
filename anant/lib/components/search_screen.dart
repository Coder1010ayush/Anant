import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<Application> data;
  List<String> appList = [];
  Map<String, String> mapping = {};
  CustomSearchDelegate({required this.data}) {
    for (Application app in data) {
      appList.add(app.appName);
      mapping[app.appName] = app.packageName;
    }
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        toolbarTextStyle: TextStyle(color: Colors.blue.shade100),
        titleTextStyle: TextStyle(color: Colors.blue.shade300),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.blue.shade300),
        border: InputBorder.none,
      ),
      textTheme: TextTheme(
        titleLarge:
            TextStyle(color: Colors.blue.shade800, fontFamily: "FiraCode"),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        color: Colors.white,
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      color: Colors.black,
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = appList
        .where((element) => element.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Container(
      color: Colors.black,
      child: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          return ListTile(
            textColor: Colors.red.shade400,
            title: Text(appList[index]),
            onTap: () {
              //(context, results[index]);
              _launchApp(context, mapping[appList[index]]!);
            },
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = appList
        .where((element) => element.toLowerCase().contains(query.toLowerCase()))
        .toList();
    suggestions.sort();

    return Container(
      color: Colors.black,
      child: ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return ListTile(
            textColor: const Color.fromARGB(255, 8, 238, 20),
            title: Text(suggestions[index]),
            onTap: () {
              query = suggestions[index].toLowerCase();
              // showResults(context);
              _launchApp(context, mapping[suggestions[index]]!);
            },
          );
        },
      ),
    );
  }

  Future<void> _launchApp(BuildContext context, String packageName) async {
    bool isOpened = await DeviceApps.openApp(packageName);
    if (!isOpened) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to open app $packageName'),
      ));
    }
  }
}
