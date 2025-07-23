import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:toast/toast.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

class SettingWallpaper extends StatefulWidget {
  final String url;
  const SettingWallpaper({super.key,required this.url});

  @override
  State<SettingWallpaper> createState() => _SettingWallpaperState();
}

class _SettingWallpaperState extends State<SettingWallpaper> {

  @override
  void initState() {
    super.initState();
    ToastContext().init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
      ),
      body: Column(
        children: [
          Expanded(child: Container(
            margin: EdgeInsets.all(10),
            child: Image.network(widget.url,fit: BoxFit.cover),
          )),
          GestureDetector(
            onTap: (){
              showDialog(context: context, builder: (context) {
                return SimpleDialog(
                  elevation: 10,
                  backgroundColor: Colors.white,
                  title: Text("Choose location for your wallpaper",style: TextStyle(color: Colors.black),),
                  children: [
                    TextButton(onPressed: () async{
                      Navigator.pop(context);
                      var file = await DefaultCacheManager().getSingleFile(widget.url);
                      await WallpaperManagerFlutter().setWallpaper(file, WallpaperManagerFlutter.homeScreen);
                      Toast.show("Wallpaper successfully set for Homescreen",duration: Toast.lengthLong,backgroundRadius: 5,backgroundColor: Colors.black,gravity: Toast.bottom,textStyle: TextStyle(color: Colors.white));
                    },
                        child: Text("HomeScreen",style: TextStyle(color: Colors.black),)),

                    TextButton(onPressed: () async{
                      Navigator.pop(context);
                      var file = await DefaultCacheManager().getSingleFile(widget.url);
                      await WallpaperManagerFlutter().setWallpaper(file, WallpaperManagerFlutter.lockScreen);
                      Toast.show("Wallpaper successfully set for Lockscreen",duration: Toast.lengthLong,backgroundRadius: 5,backgroundColor: Colors.black,gravity: Toast.bottom,textStyle: TextStyle(color: Colors.white));
                    },
                        child: Text("LockScreen",style: TextStyle(color: Colors.black),)),
                    TextButton(onPressed: () async{
                      Navigator.pop(context);
                      var file = await DefaultCacheManager().getSingleFile(widget.url);
                      await WallpaperManagerFlutter().setWallpaper(file, WallpaperManagerFlutter.bothScreens);
                      Toast.show("Wallpaper successfully set for both screens",duration: Toast.lengthLong,backgroundRadius: 5,backgroundColor: Colors.black,gravity: Toast.bottom,textStyle: TextStyle(color: Colors.white));
                    },
                        child: Text("Both",style: TextStyle(color: Colors.black),))
                  ],
                );
              },);
            },
            child: Container(color: Colors.black,
                height: 80 ,
                padding: EdgeInsets.only(top: 5),
                width: double.infinity,
                child: Card(elevation: 10,
                    child: Center(child: Text("Set Wallpaper",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)))),),
          ),
        ],
      ),
    );
  }
}
