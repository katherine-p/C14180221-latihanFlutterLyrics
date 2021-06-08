import 'package:http/http.dart' as http;
import 'dart:convert';

class dataAPI {
  int myid;
  String myemail;

  dataAPI({this.myid, this.myemail});

  factory dataAPI.createData(Map<String, dynamic> object)
  {
    return dataAPI(myid: object['track_id'], myemail: object['track']);
  }

  static Future<dataAPI> connectToAPI() async {
    String urlAPI = "http://api.musixmatch.com/ws/1.1/track.search?q_track=imagine&q_artist=ariana&apikey=	1548e749dd2a02f8962dc508696c1f77";
    var apiresult = await http.get(Uri.parse(urlAPI));

    var jsonObject = json.decode(apiresult.body);
    var data = (jsonObject as Map<String, dynamic>)['track_list'];
    return dataAPI.createData(data);

  }
}