import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:device_info_plus/device_info_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Application> apps = [];
  late String deviceInfo = '';

  Future<void> _findInstalledApplicationOnSystem() async {
    List<Application> appList = await DeviceApps.getInstalledApplications(
      includeSystemApps: true,
      onlyAppsWithLaunchIntent: true,
    );
    setState(() {
      apps = appList;
    });
  }

  Future<void> _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
    setState(() {
      deviceInfo =
          '''Type: ${androidInfo.type}\nDevice: ${androidInfo.device}\nModel: ${androidInfo.model}\nHardware: ${androidInfo.hardware}\nManufacturer: ${androidInfo.manufacturer}\nProduct: ${androidInfo.product}''';
    });
  }

  @override
  void initState() {
    super.initState();
    _findInstalledApplicationOnSystem();
    _getDeviceInfo();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
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
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: width / 3,
                  height: height / 4,
                  child: SizedBox(
                    width: 80,
                    height: 70,
                    child: Image.asset(
                      "assets/images/logo.jpg",
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                  height: height / 4,
                  width: width / 1.5,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 50, top: 50),
                    child: Text(
                      deviceInfo,
                      style: TextStyle(
                        color: Colors.blue.shade400,
                        fontFamily: "FiraCode",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            widgetFetcher(height, width),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/application',
            arguments: apps,
          );
        },
        backgroundColor: const Color.fromARGB(255, 11, 125, 239),
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }

  Widget widgetFetcher(double height, double width) {
    return SizedBox(
      height: height / 1.7,
      width: width,
      child: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.1, horizontal: 16.0),
            title: GestureDetector(
              onTap: () {
                _launchApp(context, apps[index].packageName);
              },
              child: Text(
                apps[index].appName,
                style: TextStyle(
                  color: Colors.red.shade500,
                  fontFamily: 'FiraCode',
                ),
              ),
            ),
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
