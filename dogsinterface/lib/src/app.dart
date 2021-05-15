import 'package:dogsinterface/src/screens/imagelist_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Views home",
      theme: new ThemeData(
        primaryColor: Colors.deepOrange
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("View this awesome dogs dude!"),
        ),
        body: ImageList(),
      ),
    );
  }
}


