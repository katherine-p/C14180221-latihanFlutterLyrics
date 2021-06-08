import 'package:http/http.dart' as http;
import 'dart:convert';

class dataAPI {
  int id;
  String name;

  dataAPI({this.id, this.name});

  factory dataAPI.createData(Map<String, dynamic> object)
  {
    return dataAPI(id: object['track_id'], name: object['track_name']);
  }

  static Future<dataAPI> connectToAPI() async {
    String urlAPI = "http://api.musixmatch.com/ws/1.1/track.get?commontrack_id=117288952&apikey=1548e749dd2a02f8962dc508696c1f77";
    var apiresult = await http.get(Uri.parse(urlAPI), headers: {"Accept": "application/json"});

    var jsonObject = json.decode(apiresult.body);
    print(apiresult.body.toString());
    if (apiresult.statusCode == 200) {
      var data = (jsonObject as Map<String, dynamic>)['message']['body']['track'][0];
      return dataAPI.createData(data);
    } 
    else {
      throw Exception('Failed to load post');
    }
    

  }
}