import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaperapp/fullscreen.dart';
import 'package:wallpaperapp/splashscreen.dart';

class WallpaperApp extends StatefulWidget {
  const WallpaperApp({super.key});

  @override
  State<WallpaperApp> createState() => _WallpaperAppState();
}

class _WallpaperAppState extends State<WallpaperApp> {
  List images = [];
  int page = 1;

  @override
  void initState() {
    super.initState();
    fetchPhotos();
  }

  Future fetchPhotos() async{
    var response =  await http.get(Uri.parse("https://api.pexels.com/v1/curated?per_page=80"),
        headers:{
      "Authorization" : "jxmzXQEdDd0YqhaEZKoDwbTFo4BRdPZ6JdFAW556kvKoZZaeYGM6z1i4"
    });

    if(response.statusCode == 200){
      Map result = jsonDecode(response.body);   //Converted the json String into Dart Map Object
      setState(() {
        images = result['photos'];              // Stored the photos key separately into a list
      });
    }else{
      print("Something went wrong ${response.statusCode}");
    }
  }

  Future loadMoreImages() async{
    page = page + 1;
    var nextResponse =  await http.get(Uri.parse("https://api.pexels.com/v1/curated?per_page=80&page=$page"),
        headers:{
          "Authorization" : "jxmzXQEdDd0YqhaEZKoDwbTFo4BRdPZ6JdFAW556kvKoZZaeYGM6z1i4"
        });
    Map result = jsonDecode(nextResponse.body);
    setState(() {
      images.addAll(result['photos']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: Container(
            child: GridView.builder(itemCount: images.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 3,childAspectRatio: 2/3,mainAxisSpacing: 3), itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => SettingWallpaper(url: images[index]['src']['large2x'],),));
                },
                child: Container(
                  child: Image.network(images[index]['src']['tiny'],fit: BoxFit.cover,),
                ),
              );
            },),
          )),
          GestureDetector(
            onTap: () async{
              await loadMoreImages();
            },
            child: Container(color: Colors.black,
              height: 80 ,
              width: double.infinity,
              child: Card(
                elevation: 10,
                child: Center(child: Text("Load More Images",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold))),
              ),),
          )
        ],
      ),
    );
  }
}
