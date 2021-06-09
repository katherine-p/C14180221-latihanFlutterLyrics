import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'song.dart';

class lyrics extends StatefulWidget {
  @override
  _lyricsState createState() => _lyricsState();

  final song mysong;
  lyrics(this.mysong);
}

class _lyricsState extends State<lyrics> {
  String lyric; 

  @override
  void initState() {
    this.getLyrics();
    super.initState();
  }

  Future<String> getLyrics() async {
    int tid = widget.mysong.id;
    final String urlAPI = "https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=${tid}&apikey=1548e749dd2a02f8962dc508696c1f77";
    var apiresult = await http.get(Uri.parse(urlAPI), headers: {"Accept": "application/json"});

    setState(() {
      var jsonObject = json.decode(apiresult.body)['message']['body']['lyrics']['lyrics_body'];
      //print(apiresult.body.toString());
      //print(jsonObject.length);
      lyric = jsonObject;
      print('liriikkkkk');
      print(lyric);
    });

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text(widget.mysong.name),
        backgroundColor: Colors.green[200],
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(lyric != null ? lyric : 'kozong')
            ]
          ),
        ),
      ),
    );
  }
}
