import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ocp/configs/AppColors.dart';
import 'package:ocp/network/NetworkCall.dart';
import 'package:http/http.dart' as http;


class Home extends StatelessWidget {
  final List<Color> colors = [AppColors.lightTeal, AppColors.lightTeal];
  final List<Color> colors2 = [Color(0xffff7ae9), Color(0xfff2855c)];
  String imagePath;


  Home(this.imagePath);
 /* Home(String imagePath, http.StreamedResponse response){
    this.imagePath=imagePath;
    this.response=response;
  }*/

  results  () async{
    ImageData my_res=  await uploadImageToServer(File(imagePath));
    print(my_res);
    return my_res.prediction;
  }




  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 410,
              child: Stack(
                children: <Widget>[
                  buildTopGradient(size),
                  buildTitle(),
                  buildImage(),
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.notifications),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            buildInfoColumn1(),
            buildBottomRow(size),
          ],
        ),
      ),
    );
  }

  Widget buildTopGradient(Size size) {
    return Container(
      height: 300,
      width: size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50)
          ),
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.2, 1],
          )
      ),
    );
  }

  Widget buildTitle() {
    return Positioned(
      child: ClipRRect(
        borderRadius: new BorderRadius.circular(30),
        child: Center(
          child: Text(
            "This is the prediction",
            style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'Great_Vibes',
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      left: 30,
      right: 30,
      top: 100,
    );
  }

  Widget buildImage() {
    return Positioned(
      child: ClipRRect(
        borderRadius: new BorderRadius.circular(30),
        child: Image.file(File(imagePath), fit: BoxFit.cover)
      ),
      left: 30,
      right: 30,
      top: 180,
    );
  }

  Widget buildInfoColumn() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          Text(
            '${results()}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Container(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Accuracy: ${results()}",
                style: TextStyle(color: Colors.blueGrey.shade600),
              ),
            ],
          ),
          Container(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                color: Colors.blueGrey,
                icon: Icon(FontAwesomeIcons.instagram),
                onPressed: () {},
              ),
              IconButton(
                color: Colors.blueGrey,
                icon: Icon(FontAwesomeIcons.facebookF),
                onPressed: () {},
              ),
              IconButton(
                color: Colors.blueGrey,
                icon: Icon(FontAwesomeIcons.twitter),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget buildInfoColumn1() {

    return FutureBuilder(
        future: uploadImageToServer(File(imagePath)),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          print(snapshot.data);
          if(snapshot.data == null){
            return Container(
                child: Center(
                    child: Text("Loading...")
                )
            );
          }else{
            return Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                children: <Widget>[
                  Text(
                    '${snapshot.data.prediction}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Container(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Accuracy: ${snapshot.data.accuracy}",
                        style: TextStyle(color: Colors.blueGrey.shade600),
                      ),
                    ],
                  ),
                  Container(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        color: Colors.blueGrey,
                        icon: Icon(FontAwesomeIcons.instagram),
                        onPressed: () {},
                      ),
                      IconButton(
                        color: Colors.blueGrey,
                        icon: Icon(FontAwesomeIcons.facebookF),
                        onPressed: () {},
                      ),
                      IconButton(
                        color: Colors.blueGrey,
                        icon: Icon(FontAwesomeIcons.twitter),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            );

          }

    },
    );

  }



  Widget buildBottomRow(Size size) {
    return Container(
      margin: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 30),
      height: 90,
      child: Stack(
        children: <Widget>[
          Container(
            width: size.width,
            margin: EdgeInsets.only(top: 30),
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                gradient: LinearGradient(
                  colors: colors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.2, 1],
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  onPressed: null,
                ),
                IconButton(
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                  onPressed: null,
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: null,
                ),
                IconButton(
                  icon: Icon(
                    Icons.message,
                    color: Colors.white,
                  ),
                  onPressed: null,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 35,
            left: size.width / 2.7,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {},
              child: Icon(
                Icons.favorite,
                color: Colors.pink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
