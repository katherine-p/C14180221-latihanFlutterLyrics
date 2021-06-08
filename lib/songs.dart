import 'package:flutter/material.dart';

class Songs extends StatelessWidget {
  final topSongs;

  Songs(this.topSongs);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              topSongs['track_name'],
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            Text(topSongs['artist_name']),
          ],
        ),
        padding: const EdgeInsets.all(20.0),
      ),
    );
  }
}
