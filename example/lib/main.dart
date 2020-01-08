import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:magiceye/magiceye.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MagicEye'),
        ),
        body: Center(
          child: LoucoButton(),
        ),
      ),
    );
  }
}

class LoucoButton extends StatelessWidget {
  final StreamController<File> file = StreamController.broadcast();

  LoucoButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("Take picture"),
            onPressed: () => MagicEye().push(context).then(
                  (path) => path.fold(
                    (_) => null,
                    (path) => file.add(
                      File(path),
                    ),
                  ),
                ),
          ),
          SizedBox(height: 16),
          StreamBuilder<File>(
            stream: file.stream,
            initialData: null,
            builder: (context, snapshot) => snapshot.hasData
                ? Image.file(snapshot.data)
                : Container(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
