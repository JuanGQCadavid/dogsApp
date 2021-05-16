import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' show get;
import '../api_key.dart';

class ImageList extends StatefulWidget {
  createState() {
    return new ImageListState();
  }
}

class ImageListState extends State<ImageList> {
  List _images = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: [
          _searchField(),
          _displayImage(_images)
        ],
      ),
    );
  }

  Future<List> _makeRequest (query) async {
    String unplash_request = 'https://api.unsplash.com/search/photos?query=$query&client_id=$ACCESS_KEY';
    final response = await get(unplash_request);

    print(response);

    final img = json.decode(response.body);

    print(img);

    setState(() {
      _images = img['results'];
      print(img['results']);

    });
  }

  Widget _searchField() {
    return TextField(
      onChanged: (query) {
        print(query);
        //_makeRequest(query);
      },
      onSubmitted: (query) {
        print("Nos pi");
        _makeRequest(query);
        //_makeRequest(query);
      },

      decoration: InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.search),
        hintText: "Lets try with some fancy dogs",
        hintStyle: TextStyle(
          fontWeight: FontWeight.w200
        )

      ),
    );
  }

  Widget _displayImage (List images) {
    return images.isEmpty
        ? Center( child: new CircularProgressIndicator(),)
        : Expanded(
            child: ListView.builder(
              itemCount: images == null ? 0 :  images.length,
              itemBuilder: (context, int index) {
                return _buildImage(images.elementAt(index));
              },
            )

    );
  }

  Widget _buildImage(dynamic image) {
    return Container(
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey)
      ),

      child: Column(
        children: [
          Container(
            child: Image.network(
              image['urls']['small'],
              fit: BoxFit.fitWidth,
              height: 200.0,
            ),
            padding: EdgeInsets.only(
              bottom: 8.0
            ),
          ),
          Text(
            image["description"] == null
                ? image["alt_description"] == null ? "Dude, there is nothing about this one" : image["alt_description"]
                : image["description"]
          )

        ],
      )
    );

  }


}


