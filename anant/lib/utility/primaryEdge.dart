// ignore_for_file: file_names
import 'dart:core';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
getOutputWidget(String cmd, String value) {
  String str = "Launched $value application";
  var widg = Text(
    str,
    style: const TextStyle(
        color: Color.fromARGB(255, 235, 20, 20),
        fontFamily: 'Fira Code',
        fontSize: 13,
        fontWeight: FontWeight.w800),
  );
  return widg;
}

getRenderingWidget(String cmd, String value) {
  String str = "Rendering display $value on 220233L2I";
  var widg = Text(
    str,
    style: const TextStyle(
        color: Color.fromARGB(255, 239, 9, 9),
        fontFamily: 'Fira Code',
        fontSize: 13,
        fontWeight: FontWeight.w500),
  );
  return widg;
}


getOutputWidgetInfo(String cmd , String value , Application app)
{
  String appname = app.appName; 
  int appver = app.versionCode;
  String? versioncode = app.versionName;
  String path = app.packageName;
  String category = app.category.toString();
  int instime = app.installTimeMillis; 
  int uptime = app.updateTimeMillis;

  var styl =const TextStyle
  ( 
    color: Colors.red, 
    fontFamily: 'Fira Code', 
    fontSize: 12, 
    fontWeight: FontWeight.w900
  );

  var widgt =SizedBox(
    child:
   Column
  (
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    
    children:  [ 
      Text
      (
        "AppName : $appname",
        style: styl,
      ),
      Text
      (
        "Package Name : $path",
        style: styl,
      ),
      Text
      (
        "Version Code : $appver",
        style: styl,
      ),
      Text
      (
        "Version Name : $versioncode",
        style: styl,
      ), 
      Text
      (
        "Category of App : $category", 
        style: styl,
      ), 
      Text
      (
        "Installation time : $instime", 
        style: styl,
      ), 
      Text
      (
        "Last Updated time : $uptime", 
        style: styl,
      )
    ],
  )
  ); 
  return widgt;    
}



getRenderingWidgetInfo(String cmd , String value , Application app )
{
  String name = app.appName;
  String data = "Fetching Info of $name";
  var widgt = Text
  (
    data , 
    style: const TextStyle
    (
      color: Colors.red, 
      fontFamily: 'Fira Code', 
      fontSize: 13, 
      fontWeight: FontWeight.w900
    ),
  ); 
  return widgt;
}
