// ignore_for_file: file_names, avoid_print

import 'package:anant/utility/primaryEdge.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

List<Widget> commandParser(String command, BuildContext context,
  List<Widget> widgetList, Map<String, Application> mapping) {
  List<Widget> widgetList = [];
  // splitting the command and break down into two segment
  // first is cmd and second is input string text
  String cmd = "";
  String value = "";
  for (int i = 0; i < command.split(" ").length; i++) 
  {
    if (i == 0) {
      cmd = command.split(" ")[0];
    } else {
      value += "${command.split(" ")[i]} ";
    }
  }
  value = value.substring(0, value.length-1);
  print(value);
  print(mapping[value]?.packageName);
  if (cmd == "launch")
  {
    var renderingWidget = getRenderingWidget(cmd, value);
    var actionWidget = getOutputWidget(cmd, value);
    widgetList.add(renderingWidget);
    widgetList.add(actionWidget);
    DeviceApps.openApp(mapping[value]!.packageName);
  } 
  else if (cmd == "info")
  {
    Application app = mapping[value]!;
    var renderingWidget = getRenderingWidgetInfo(cmd, value,app);
    var actionWidget = getOutputWidgetInfo(cmd, value,app);
    widgetList.add(renderingWidget);
    widgetList.add(actionWidget);
  }
  else if (cmd == "clear")
  {
    var wdg = widgetList[widgetList.length-1];
    widgetList.clear();
    var f1 = const Text
    (
      "Cleared console", 
      style: TextStyle
      (
        color: Colors.green, 
        fontFamily: 'Fira Code', 
        fontSize: 12 , 
        fontWeight: FontWeight.w900
      ),
    );
    widgetList.add(f1);
    widgetList.add(wdg);
  }
  return widgetList;
}
