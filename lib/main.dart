import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'dart:convert';

void main() => runApp(HomePage());

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File image = new File("assets/undraw_photo_4yb9.png");
  Widget _widget = Center();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soja Scanner',
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 50.0, right: 20.0, bottom: 20.0, left: 20.0),
              child: Column(children: <Widget>[
                Text("Bem-Vindo",
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.w500)),
                SizedBox(height: 20),
                Text(
                    "Por favor Tire/Procure uma foto e pressione em verificar para avaliar se a Folha de soja está com Ferrugem ou é Sadia.",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                    textAlign: TextAlign.center),
                SizedBox(height: 10),
                Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: RaisedButton.icon(
                              color: Colors.green[400],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22.0)),
                              onPressed: () async {
                                File file =
                                    await this.getImage(ImageSource.camera);
                                setState(() {
                                  image = file;
                                });
                              },
                              icon: Icon(Icons.camera_alt, size: 30.0),
                              label: Text("Tirar foto",
                                  style: TextStyle(fontSize: 14.0)))),
                      SizedBox(width: 10),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: RaisedButton.icon(
                              color: Colors.grey[200],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22.0),
                              ),
                              onPressed: () async {
                                File file =
                                    await this.getImage(ImageSource.gallery);
                                setState(() {
                                  image = file;
                                });
                              },
                              icon: Icon(Icons.image, size: 30.0),
                              label: Text("Procurar foto",
                                  style: TextStyle(fontSize: 14.0)))),
                      SizedBox(height: 20)
                    ])),
                SizedBox(height: 20),
                Center(
                  child: Image.file(image, height: 400, width: 300),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton.icon(
                  color: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.0)),
                  onPressed: () async {
                    // Carregando o rede neural treinada
                    await Tflite.loadModel(
                      model: "assets/converted_model.tflite",
                      labels: "assets/labels.txt",
                    );
                    // Execução do reconhecimento
                    var output = await Tflite.runModelOnImage(
                      path: image.path,
                      numResults: 2,
                      threshold: 0.5,
                      imageMean: 127.5,
                      imageStd: 127.5,
                    );

                    setState(() {
                      // analise do resultado
                      if (output[0]['index'] == 0) {
                        double fer = output[0]['confidence'] * 100;
                        _widget = Text(
                            "${fer.toStringAsPrecision(4)}% da chance da folha estar com ferrugem asiática.",
                            style: TextStyle(fontSize: 16, color: Colors.red));
                      } else {
                        double sadia = output[0]['confidence'] * 100;
                        _widget = Text(
                            "${sadia.toStringAsPrecision(4)}% de chance da folha ser sadia.",
                            style:
                                TextStyle(fontSize: 16, color: Colors.green));
                      }
                    });
                  },
                  icon: Icon(Icons.backup, size: 40.0),
                  label: Text("Verificar", style: TextStyle(fontSize: 24.0)),
                ),
                SizedBox(height: 20),
                _widget
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Future<File> getImage(ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);
    return image;
  }
}
