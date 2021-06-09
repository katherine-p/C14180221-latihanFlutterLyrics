import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'lyrics.dart';
import 'song.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => Home(),
        '/lyrics': (context) => lyrics(ModalRoute.of(context).settings.arguments as song)
      },
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = TextEditingController();
  //dataAPI tracks = null;

  List<dynamic> tracks;

  @override
  void initState() {
    this.connectToAPI();
    super.initState();
  }

  Future<String> connectToAPI() async {
    final String urlAPI =
        "http://api.musixmatch.com/ws/1.1/album.tracks.get?album_id=40633567&apikey=1548e749dd2a02f8962dc508696c1f77";
    var apiresult = await http
        .get(Uri.parse(urlAPI), headers: {"Accept": "application/json"});

    setState(() {
      var jsonObject =
          json.decode(apiresult.body)['message']['body']['track_list'];
      //print(apiresult.body.toString());
      //print(jsonObject.length);
      tracks = jsonObject;
      print(tracks);
      print(tracks[0]['track']['track_name']);
      // for(int i = 0; i < jsonObject.length; i++)
      // {
      //   var data = (jsonObject as List<dynamic>)[i];
      //   print(data);
      //   dataAPI.createData(data);
      // }
    });

    return 'ayoolahhh';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text('Positions'),
        backgroundColor: Colors.green[200],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              "https://images.genius.com/19f6cba5a8b80305ef20723150e5ac72.707x707x1.png",
              width: 200,
            ),
            // TextField(
            //     controller: _controller,
            //     decoration: InputDecoration(hintText: 'Enter song title')),
            // MyButton('Search', pressbutton: search),
            // Text(tracks != null ? tracks[0]['track']['track_name'] : 'kosongg'),
            Row(
              children: <Widget>[
                Expanded(
                    child: SizedBox(
                      height: 200,
                      child: new ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: (tracks != null ? tracks.length : 0),
                        itemBuilder: (BuildContext context, int index) {
                          return FlatButton(
                            color: Colors.purple[200],
                            child: Text(
                              tracks[index]['track']['track_name'].toString()),
                            onPressed: () {
                              int id = tracks[index]['track']['track_id'];
                              String nama = tracks[index]['track']['track_name'];
                              song thesong = song(id: id, name: nama);
                              print(id);
                              Navigator.pushNamed(context, '/lyrics', arguments: thesong);
                            },
                          );
                      }),
                ))
              ],
            ),
          ],
        ),
      ),
    );
    void dispose() {
      _controller.dispose();
      super.dispose();
    }
  }
}
