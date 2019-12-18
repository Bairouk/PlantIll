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
  String accuracy;
  ImageData(this.uri,this.prediction,this.accuracy);
}
// upload image to our server
Future<ImageData> uploadImageToServer(File imageFile) async
{
  print("attempting to connecto server......");
  var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  var length = await imageFile.length();
  print(length);

  var uri = Uri.parse('http://480bed17.ngrok.io/predict');
  print("connection established.");
  var request = new http.MultipartRequest("POST", uri);
  var multipartFile = new http.MultipartFile('file', stream, length,
      filename: basename(imageFile.path));
  //contentType: new MediaType('image', 'png'));
  request.files.add(multipartFile);
  print("waiting for response");
  var response = await request.send();
  var respStr = await response.stream.bytesToString();
  var jsondata = json.decode(respStr);
  print('Bihy here');
//  print(json.decode(response.body));
  print(jsondata);
  print(response.statusCode);
  var my_resp =ImageData('nothing',jsondata['predi']['prediction'],jsondata['predi']['confidence']);
  return my_resp;
}