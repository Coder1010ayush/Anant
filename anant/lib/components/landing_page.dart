import 'package:flutter/material.dart';
import 'package:anant/functions/primaryFunction.dart';
import 'package:device_apps/device_apps.dart';
import 'dart:core';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late Widget initialWidget;
  final TextEditingController _controller = TextEditingController();
  List<Widget> frontPageWidgetList = [];
  List<Application> appList = [];
  Map<String , Application> mapping = {};
  bool isBluetoothOn = false;
  


  Future<void> _findInstalledApplication() async {
    List<Application> apps = await DeviceApps.getInstalledApplications(
        onlyAppsWithLaunchIntent: true,includeSystemApps: true);
    setState(() {
      apps.sort((a, b) => a.appName.compareTo(b.appName));
      for (int i = 0; i < apps.length; i++) {
        String appname = apps[i].appName;
        mapping[appname] = apps[i];
      }
      // print("hello");
      // print(mapping);
      // print(mapping.length);
      // print("hello");
      appList = apps;
    });
  }
    @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _findInstalledApplication();
  }



  @override 
  Widget build(BuildContext context)
  
  {
    var widgt = Container(
      color: Colors.black,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 70,
            height: 40,
            child: Text(
              "@coder ",
              style: TextStyle(
                  color: Colors.green,
                  fontFamily: 'Fira Code',
                  fontSize: 14,
                  fontWeight: FontWeight.w800),
            ),
          ),
          SizedBox(
            width: 245,
            height: 20,

            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hoverColor: Colors.purpleAccent,
                focusColor: Colors.blueAccent,
                border: InputBorder.none,
              ),
              showCursor: false,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  color: Color.fromRGBO(125, 9, 208, 1),
                  fontFamily: 'Fira Code',
                  fontSize: 14,
                  fontWeight: FontWeight.w900),
              onSubmitted: (value) {
                setState(() {
                  _executeCommand(value, context, frontPageWidgetList , mapping);
                });
                _controller.clear();
              },
            ),
          )
        ],
      ),
    );
    initialWidget = widgt;
    return MaterialApp
    (
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home:  Scaffold 
      (
        appBar: AppBar
        ( 
          toolbarHeight: 70.0, 
          shadowColor: Colors.deepPurple,
          backgroundColor: Colors.black,
          foregroundColor: Colors.black,
          title:  Row
          (
            mainAxisAlignment: MainAxisAlignment.center,
            children:
            [  
              Container
              (
                padding:const EdgeInsets.all(10),
                margin : const EdgeInsets.all(10),
                width: 40 , 
                height: 40,
                decoration: const BoxDecoration
                ( 
                  color: Colors.black,
                  borderRadius: BorderRadius.all
                  (
                    Radius.circular(20)
                  ),
                  image: DecorationImage
                  (
                    image: AssetImage("assets/images/pi.jpeg"), 
                    fit: BoxFit.cover
                  )
                ),
              ),
              const Text
              (
                'Anant' , 
                style: TextStyle
                ( 
                  color: Colors.green, 
                  fontFamily: 'Fira Code', 
                  fontWeight: FontWeight.w800,
                  fontSize: 20
                ),
              )
            ]
          )
        ),
        body: Column

        ( 
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children:
          [ 
            Expanded
            ( 
              child:frontPageWidgetList.isEmpty ? widgt:
              Container
              (
                color:const Color.fromARGB(255, 7, 0, 0),
                child: ListView.builder
                (
                  physics:const AlwaysScrollableScrollPhysics(),
                  itemCount: frontPageWidgetList.length,
                  itemBuilder:
                  (
                    context , index
                  )
                  {
                    return ListTile 
                    (
                      title: frontPageWidgetList[index],
                    );
                  }
                ),
              )
            ), 
            Container
            (
              height: 60,
              color: Colors.black,
              // width: 400,
              child: ListView.builder
            
              (
                scrollDirection: Axis.horizontal,
                itemCount: appList.length,
                itemBuilder: (context,index)
                {
                    return Container
                    (
                      width: 120,
                      margin:const EdgeInsets.all(10),
                      color: const Color.fromARGB(255, 3, 96, 6),
                      padding:const EdgeInsets.only(left: 10),
                      child:Center
                      (
                        child: GestureDetector(
                          onTap: ()
                          {
                            DeviceApps.openApp(appList[index].packageName);
                          },
                          child: Text
                          (
                            appList[index].appName, 
                            style :const TextStyle
                            (
                              color: Colors.black,
                              fontFamily: 'Fira Code',
                              fontWeight: FontWeight.w800
                            ),
                          
                            
                          ),
                        ),
                      ) 
                    ) ;
                }
              ),
            )
          ]
        )
      )
    );
  }
  
  void _executeCommand
    (
      String value, BuildContext context, List<Widget> frontPageWidgetList, Map<String,Application> mapping
    )
    {
      
    List<Widget> localList;
    List<Widget> wigList =
    localList =  commandParser(value, context, frontPageWidgetList, mapping);
    setState
    (
      () 
      { 
        if (localList.length ==1)
        {
          frontPageWidgetList.add(wigList[0]);
        }
        else if ( localList.length == 2)
        { 
          frontPageWidgetList.add(wigList[0]);
          frontPageWidgetList.add(wigList[1]);
        }
        
        if (frontPageWidgetList.length == 2 || frontPageWidgetList.length ==1)
        {
          frontPageWidgetList.add(initialWidget);
        }
        else if(frontPageWidgetList.length >2)
        {
          frontPageWidgetList.removeAt(frontPageWidgetList.length-3);
          frontPageWidgetList.add(initialWidget);
        }

     }
    );
  }
}
    
  