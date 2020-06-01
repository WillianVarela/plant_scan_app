import 'package:flutter/material.dart';
import 'package:scan/app/shared/router.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Plant Scan",
      theme: ThemeData(
        primaryColor: Colors.green[300],
      ),
      initialRoute: homeModule,
      onGenerateRoute: Router.generateRoute,
    );
  }
}