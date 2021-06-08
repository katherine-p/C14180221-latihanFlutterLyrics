import 'package:http/http.dart' as http;
import 'dart:convert';

class dataAPI {
  List<int> id;
  List<String> name;

  dataAPI(tid, tname)
  {
    this.id.add(tid);
    this.name.add(tname);
  }

  factory dataAPI.createData(Map<String, dynamic> object)
  {
    return dataAPI(object['track_id'], object['track_name']);
  }

  static Future<dataAPI> connectToAPI() async {
    String urlAPI = "http://api.musixmatch.com/ws/1.1/album.tracks.get?album_id=40633567&apikey=1548e749dd2a02f8962dc508696c1f77";
    var apiresult = await http.get(Uri.parse(urlAPI), headers: {"Accept": "application/json"});

    var jsonObject = json.decode(apiresult.body)['message']['body']['track_list'];
    print(apiresult.body.toString());
    print(jsonObject.length);
    for(int i = 0; i < jsonObject.length; i++)
    {
      var data = (jsonObject as List<dynamic>)[i];
      print(data);
      dataAPI.createData(data);
    }

    
  }
}