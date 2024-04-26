// ignore_for_file: file_names, avoid_print

import 'package:anant/utility/primaryEdge.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'dart:core';

List<Widget>  commandParser(String command, BuildContext context,
  List<Widget>finalWidgetlist, Map<String, Application> mapping) {
  List<Widget> widgetList = [];
  command = command.trim();
  // splitting the command and break down into two segment
  // first is cmd and second is input string text
  String cmd = "";
  String value = "";
  if(command.startsWith("launch") || command.startsWith("info")){
    for (int i = 0; i < command.split(" ").length; i++) {
      if (i == 0) {
        cmd = command.split(" ")[0];
      } else {
        value += "${command.split(" ")[i]} ";
      }
    }

    if (value.isNotEmpty) {
      value = value.substring(0, value.length - 1);
    }

  }
  else 
  {
    if (command == "clear")
    {
      cmd = "clear";
    }
  }
  if (cmd == "launch")
  {
    if (mapping[value] != null)
    {

      var renderingWidget = getRenderingWidget(cmd, value);
      var actionWidget = getOutputWidget(cmd, value);
      widgetList.add(renderingWidget);
      widgetList.add(actionWidget);
      DeviceApps.openApp(mapping[value]!.packageName);
      
    }
    else 
    {
      var widg = showMessage("$value App is not found");
      var widg1 = showMessage("Can't open $value  application");
      widgetList.add(widg);
      widgetList.add(widg1);
    }
    return widgetList;
  } 
  else if (cmd == "info")
  {
    try 
    {
      Application app = mapping[value]!;
      var renderingWidget = getRenderingWidgetInfo(cmd, value, app);
      var actionWidget = getOutputWidgetInfo(cmd, value, app);
      widgetList.add(renderingWidget);
      widgetList.add(actionWidget);
      DeviceApps.openAppSettings(app.packageName); 

    } 
    catch (e) 
    {
      var widg = showMessage("$value App is not found");
      var helper =  showMessage("Give correct name of application!");
      widgetList.add(widg);
      widgetList.add(helper);
    }
    return widgetList;
   
  }
  else if (cmd == "clear")
  {
    finalWidgetlist.clear();
    DateTime time = DateTime.now(); 
    String str = "Cleared console at time stamp $time";
    var f1 = Text
    (
      str, 
      style :const TextStyle
      (
        color: Color.fromARGB(255, 228, 8, 8), 
        fontFamily: 'Fira Code', 
        fontSize: 12 , 
        fontWeight: FontWeight.w900
      ),
    );
    widgetList.add(f1);
  }

  else if (cmd == "call")
  {
    final RegExp alphaNumeric = RegExp(r'^[a-zA-Z0-9]+$');
    bool match =  alphaNumeric.hasMatch(value);

    if (match)
    {
      callHandlerAlphanumeric(value);
    }
    else 
    {
      callHandlerName(value);
    }
  }
  return widgetList;
}
