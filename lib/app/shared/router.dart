import 'package:flutter/material.dart';
import 'package:scan/app/modules/home/home_module.dart';

const String homeModule = '/';
const String resultModule = '/';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeModule:
        return MaterialPageRoute(builder: (_) => HomeModule());
      case homeModule:
        return MaterialPageRoute(builder: (_) => HomeModule());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                  'Desculpe-nos, não existe uma rota definida para ${settings.name}'),
            ),
          ),
        );
    }
  }
}
