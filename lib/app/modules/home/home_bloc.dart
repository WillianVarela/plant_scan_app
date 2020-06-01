import 'dart:convert';
import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class HomeBloc extends BlocBase {
  Future<List> getResult(ImageSource source) async {

    File image = await ImagePicker.pickImage(source: source);
    List<int> imageBytes = image.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    var respoonse = await http.post(
      'https://plantscan.herokuapp.com/api/v1/analise',
      headers: <String, String>{
        'Content-Type': 'multipart/form-data; charset=UTF-8',
        'Connection': 'keep-alive',
        'Accept': '*',
        'Accept-Encoding': 'gzip, deflate, br'
      },
      body: jsonEncode(<String, String>{
        'base64': base64Image,
      }),
    );
    print(respoonse);
    return [];
    try {
      Dio dio = new Dio();
      dio.options.headers['content-Type'] = 'multipart/form-data';
      dio.options.headers['Connection'] = 'keep-alive';
      dio.options.headers['Accept'] = '*/*';
      dio.options.headers['Accept-Encoding'] = 'gzip, deflate, br';
      Response response = await dio.post(
          "https://plantscan.herokuapp.com/api/v1/analise", data: {"base64": base64Image},);
      return response.data["data"];
    } catch (e) {
      print(e);
      return e;
    }
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }
}
