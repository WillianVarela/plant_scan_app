import 'package:flutter/material.dart';
import 'package:scan/app/modules/home/home_bloc.dart';
import 'package:scan/app/modules/home/home_module.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key key, this.title = "Configuração Inicial"})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _bloc = HomeModule.to.getBloc<HomeBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 80.0, right: 20.0, bottom: 20.0, left: 20.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Bem-Vindo",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Por favor selecione um meio para enviar a foto da folha de soja.",
                    style: TextStyle(fontSize: 26, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  ButtonTheme(
                      minWidth: 200.0,
                      height: 100.0,
                      child: RaisedButton.icon(
                          color: Colors.green[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22.0),
                          ),
                          onPressed: () async {
                            await _bloc.getResult(ImageSource.camera);
                          },
                          icon: Icon(
                            Icons.camera_alt,
                            size: 60.0,
                          ),
                          label: Text(
                            "Tirar foto e verificar",
                            style: TextStyle(fontSize: 24.0),
                          ))),
                  SizedBox(
                    height: 40,
                  ),
                  ButtonTheme(
                      minWidth: 200.0,
                      height: 100.0,
                      child: RaisedButton.icon(
                          color: Colors.grey[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22.0),
                          ),
                          onPressed: () async {
                            await _bloc.getResult(ImageSource.gallery);
                          },
                          icon: Icon(
                            Icons.image,
                            size: 60.0,
                          ),
                          label: Text(
                            "Procurar foto e verificar",
                            style: TextStyle(fontSize: 24.0),
                          )))
                ],
              ),
            ),
          ),
        ));
  }
}
