import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'dart:io';
import 'package:path/path.dart';

class ImageData
{
//  static String  BASE_URL ='http://192.168.1.103:5000/';
  String uri;
  String prediction;
  ImageData(this.uri,this.prediction);
}
// upload image to our server
uploadImageToServer(File imageFile) async
{
  print("attempting to connecto server......");
  var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  var length = await imageFile.length();
  print(length);

  var uri = Uri.parse('http://192.168.1.103:5000/predict');
  print("connection established.");
  var request = new http.MultipartRequest("POST", uri);
  var multipartFile = new http.MultipartFile('file', stream, length,
      filename: basename(imageFile.path));
  //contentType: new MediaType('image', 'png'));
  request.files.add(multipartFile);
  var response = await request.send();
  print(response.statusCode);
  return response;
}
//our image loader
Future<List<ImageData>> LoadImages() async
{
  List<ImageData> list;
  //complete fetch ....
  var data = await http.get(
     'http://192.168.1.103:5000/api/');
  var jsondata = json.decode(data.body);
  List<ImageData> newslist = [];
  for (var data in jsondata) {

    ImageData n = ImageData(data['url'],data['prediction']);
    newslist.add(n);
  }

  return newslist; 
}