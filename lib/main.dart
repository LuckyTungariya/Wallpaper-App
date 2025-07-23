import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:wallpaperapp/fullscreen.dart';
import 'package:wallpaperapp/splashscreen.dart';
import 'package:wallpaperapp/wallpaper.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: Splashscreen()
    );
  }
}
