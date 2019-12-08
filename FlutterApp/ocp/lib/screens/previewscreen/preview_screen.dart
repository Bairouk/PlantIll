

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:ocp/configs/AppColors.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';


class PreviewImageScreen extends StatefulWidget {
  final String imagePath;

  PreviewImageScreen({this.imagePath});

  @override
  _PreviewImageScreenState createState() => _PreviewImageScreenState();
}

class _PreviewImageScreenState extends State<PreviewImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview'),
        backgroundColor: AppColors.lightTeal,
      ),
      body: Container(
        color:  AppColors.lightTeal.withOpacity(0.70),


        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Image.file(File(widget.imagePath), fit: BoxFit.cover)),
            SizedBox(height: 10.0),
            Flexible(
              flex: 1,
              child: Container(

                  padding: EdgeInsets.all(60.0),
               // Todo output the result
                  child: Text('This is some text!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontFamily: 'Lobster'
                      )
                  )
               /* child: RaisedButton(
                  onPressed: () {
                    getBytesFromFile().then((bytes) {
                    });
                  },
                  child: Text('Share'),
                ),*/
              ),
            ),
          ],
        ),
      ),
        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerDocked,

        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                heroTag: "btn1",
                onPressed: () {},
                child: Icon(Icons.navigate_before),
//                label: new Text("label"),
                backgroundColor: AppColors.lightBlue,
              ),
              FloatingActionButton(
                heroTag: "btn2",
                onPressed: () {},
                child: Icon(Icons.replay),
                backgroundColor: AppColors.lightBlue,

              )
            ],

          ),

        ),

    );
  }

  Future<ByteData> getBytesFromFile() async {
    Uint8List bytes = File(widget.imagePath).readAsBytesSync() as Uint8List;
    return ByteData.view(bytes.buffer);
  }



}


uploadImageToServer (File imageFile) async
{
  print('attempting to connect to server……');
  var stream = new http.ByteStream (DelegatingStream.typed(imageFile.openRead())) ;
  var length = await imageFile.length();
  print(length);
  var uri = Uri.parse('http://192.168.1.103:5000/predict');
  print('connection established.');
  var request = new http.MultipartRequest("POST", uri);
  var multipartFile = new http.MultipartFile('file', stream, length,
  filename: basename(imageFile.path));
//contentType: new MediaType(‘image’, ‘png’));
request.files.add(multipartFile);
  var response = await request.send();
  print(response.statusCode);
}
