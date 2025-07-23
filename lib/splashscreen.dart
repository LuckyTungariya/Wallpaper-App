import 'package:flutter/material.dart';
import 'package:wallpaperapp/wallpaper.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4),() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WallpaperApp(),));
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(10),
        child: Center(child: Container(height: 500,
            width: MediaQuery.of(context).size.width/1.5,
            child: Image.asset("assets/images/applogo.png",color: Colors.white,fit: BoxFit.contain,))),
      ),
    );
  }
}
