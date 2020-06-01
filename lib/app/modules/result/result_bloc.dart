import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';

class ResultBloc extends BlocBase {
  Future<List> getResult(String text) async {
    try {
      Dio dio = new Dio();
      //dio.options.connectTimeout = 50000;
      Response response = await dio.get(
          "servidor.comsadasd");
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
