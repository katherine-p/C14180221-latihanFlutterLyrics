import 'package:flutter/material.dart';
import 'package:lyricsapp/mybutton.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './songs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _controller = TextEditingController();
  List<dynamic> topSongs;

  void search()
  {
    this._getJsonData().then((value){
      setState(() {
        
      });
    });
  }

  Future<String> _getJsonData() async {
    String urlapi = "http://api.musixmatch.com/ws/1.1/track.search?q_track=pov&q_artist=ariana%20grande&apikey=1548e749dd2a02f8962dc508696c1f77";

    var response = await http.get(Uri.parse(urlapi));
    print('kjasdhkjsd');
    
    setState(() {
      var convertToJson = json.decode(response.body);
      topSongs = convertToJson['message']['body']['track_list'];
    });

    return "success";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.green[50],
        appBar: AppBar(
          title: Text('Ariana Grande'),
          backgroundColor: Colors.green[200],),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network("https://images.genius.com/19f6cba5a8b80305ef20723150e5ac72.707x707x1.png", width: 200,),
              TextField(
                controller: _controller,
                decoration: InputDecoration(hintText: 'Enter song title')
              ),
              MyButton('Search', pressbutton: search),
              Row(
                children: <Widget>[
                  Expanded(
                    child : SizedBox(
                      height: 200,
                      child: new ListView.builder(
                      itemCount: topSongs == null ? 0 : topSongs.length,
                      itemBuilder: (BuildContext context, int index) {
                        var song = topSongs[index]['track'];
                        Text(song);
                      },
                    )
                    ),
                    
                  )
                ],
              )
                            
            ],
          ),
        ),
      ),
    );
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
