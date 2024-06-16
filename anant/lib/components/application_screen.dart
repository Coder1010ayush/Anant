import 'package:anant/components/search_screen.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class ApplicationScreen extends StatelessWidget {
  const ApplicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final List<Application> apps =
        ModalRoute.of(context)!.settings.arguments as List<Application>;

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          actions: [
            IconButton(
                color: Colors.white,
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(data: apps),
                  );
                },
                icon: const Icon(Icons.search))
          ],
          title: Center(
            child: Text(
              "Anant",
              style: TextStyle(
                color: Colors.green.shade500,
                fontFamily: 'FiraCode',
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: size.height / 1.2,
              child: ListView.builder(
                itemCount: apps.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      apps[index].appName,
                      style: const TextStyle(
                          color: Colors.green, fontFamily: "FiraCode"),
                    ),
                    onTap: () {
                      _launchApp(context, apps[index].packageName);
                    },
                  );
                },
              ),
            )
          ],
        ));
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
