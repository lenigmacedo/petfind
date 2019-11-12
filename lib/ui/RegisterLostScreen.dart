import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:petfind/models/user_model.dart';
import 'package:petfind/theme/theme.dart' as Theme;
import 'package:scoped_model/scoped_model.dart';

class RegisterLostScreen extends StatefulWidget {
  @override
  _RegisterLostScreenState createState() => _RegisterLostScreenState();
}

class _RegisterLostScreenState extends State<RegisterLostScreen> {
  static GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController edtTipo = TextEditingController();
  TextEditingController edtRaca = TextEditingController();
  TextEditingController edtNomePet = TextEditingController();
  TextEditingController edtNomeDono = TextEditingController();
  TextEditingController edtTelefone = TextEditingController();
  TextEditingController edtDesc = TextEditingController();
  double heightForm = 1000;
  double heightScreen = 1150;
  bool autoValidate = true;

  String _picked = "Macho";
  Firestore firestore;
  var petPhoto;

  @override
  Widget build(BuildContext context) {
    Theme.Settings.statusBar;
    Theme.Settings.orientation;

    return Scaffold(
      backgroundColor: Theme.ColorsTheme.primaryColor,
      body: SingleChildScrollView(
        child: Container(
            decoration: BoxDecoration(gradient: Theme.ColorsTheme.gradient),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height >= heightScreen
                ? MediaQuery.of(context).size.height
                : heightScreen,
            child: SafeArea(
              minimum: EdgeInsets.only(top: 50),
              child: Column(
                children: <Widget>[
                  Text("Perdeu seu animal?",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: "BorisBlackBloxx")),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: heightForm,
                        width: 350,
                        child: Column(children: <Widget>[
                          Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: ScopedModelDescendant<UserModel>(
                                  builder: (context, child, model) {
                                if (model.isLoading) {
                                  return Center(
                                      child: Container(
                                    padding:
                                        EdgeInsets.fromLTRB(100, 380, 100, 400),
                                    child: CircularProgressIndicator(),
                                  ));
                                }

                                return Form(
                                  autovalidate: autoValidate,
                                  key: _formKey,
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(50, 20, 50, 30),
                                        child: TextFormField(
                                          validator: (text) {
                                            if (text.isEmpty) {
                                              return "Campo não pode ser vazio";
                                            }
                                            return null;
                                          },
                                          controller: edtTipo,
                                          keyboardType: TextInputType.text,
                                          textCapitalization:
                                              TextCapitalization.none,
                                          style: TextStyle(
                                              fontFamily: "BorisBlackBloxx",
                                              fontSize: 20,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            hintText: "Tipo do pet",
                                            hintStyle: TextStyle(
                                                fontSize: 20,
                                                fontFamily: "BorisBlackBloxx"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(50, 0, 50, 30),
                                        child: TextFormField(
                                          validator: (text) {
                                            if (text.isEmpty) {
                                              return "Campo não pode ser vazio";
                                            }
                                            return null;
                                          },
                                          controller: edtRaca,
                                          keyboardType: TextInputType.text,
                                          textCapitalization:
                                              TextCapitalization.none,
                                          style: TextStyle(
                                              fontFamily: "BorisBlackBloxx",
                                              fontSize: 20,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            hintText: "Raça do pet",
                                            hintStyle: TextStyle(
                                                fontSize: 20,
                                                fontFamily: "BorisBlackBloxx"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(30, 0, 50, 5),
                                        child: RadioButtonGroup(
                                          orientation: GroupedButtonsOrientation
                                              .VERTICAL,
                                          labels: <String>["Macho", "Fêmea"],
                                          labelStyle: TextStyle(
                                              fontFamily: "BorisBlackBloxx",
                                              fontSize: 18,
                                              color: Colors.grey[600]),
                                          onSelected: (String selected) =>
                                              setState(() {
                                            _picked = selected;
                                            print(_picked);
                                          }),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(50, 0, 50, 30),
                                        child: TextFormField(
                                          validator: (text) {
                                            if (text.isEmpty) {
                                              return "Campo não pode ser vazio";
                                            }
                                            return null;
                                          },
                                          controller: edtNomePet,
                                          keyboardType: TextInputType.text,
                                          textCapitalization:
                                              TextCapitalization.none,
                                          style: TextStyle(
                                              fontFamily: "BorisBlackBloxx",
                                              fontSize: 20,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            hintText: "Nome do pet",
                                            hintStyle: TextStyle(
                                                fontSize: 20,
                                                fontFamily: "BorisBlackBloxx"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(50, 0, 50, 30),
                                        child: TextFormField(
                                          validator: (text) {
                                            if (text.isEmpty) {
                                              return "Campo não pode ser vazio";
                                            }
                                            return null;
                                          },
                                          controller: edtNomeDono,
                                          keyboardType: TextInputType.text,
                                          textCapitalization:
                                              TextCapitalization.none,
                                          style: TextStyle(
                                              fontFamily: "BorisBlackBloxx",
                                              fontSize: 20,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            hintText: "Seu nome",
                                            hintStyle: TextStyle(
                                                fontSize: 20,
                                                fontFamily: "BorisBlackBloxx"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(50, 0, 50, 30),
                                        child: TextFormField(
                                          validator: (text) {
                                            if (text.isEmpty) {
                                              return "Campo não pode ser vazio";
                                            }
                                            return null;
                                          },
                                          controller: edtTelefone,
                                          keyboardType: TextInputType.number,
                                          textCapitalization:
                                              TextCapitalization.none,
                                          style: TextStyle(
                                              fontFamily: "BorisBlackBloxx",
                                              fontSize: 20,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            hintText: "Seu telefone",
                                            hintStyle: TextStyle(
                                                fontSize: 20,
                                                fontFamily: "BorisBlackBloxx"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(50, 0, 50, 10),
                                        child: TextFormField(
                                          validator: (text) {
                                            if (text.isEmpty) {
                                              return "Campo não pode ser vazio";
                                            }
                                            return null;
                                          },
                                          controller: edtDesc,
                                          maxLines: 5,
                                          maxLength: 140,
                                          keyboardType: TextInputType.text,
                                          textCapitalization:
                                              TextCapitalization.none,
                                          style: TextStyle(
                                              fontFamily: "BorisBlackBloxx",
                                              fontSize: 20,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            hintText: "Descrição do seu pet",
                                            hintStyle: TextStyle(
                                                fontSize: 20,
                                                fontFamily: "BorisBlackBloxx"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              50, 10, 50, 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: getImage,
                                                child: Text(
                                                  "Foto do seu pet",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          "BorisBlackBloxx",
                                                      fontSize: 20,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Icon(
                                                Icons.file_upload,
                                                size: 28,
                                              ),
                                            ],
                                          )),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 20),
                                        child: MaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          color: Theme.ColorsTheme.primaryColor,
                                          onPressed: () {
                                            if (_formKey.currentState
                                                .validate()) {
                                              Map<String, dynamic> data = {
                                                "tipo": "${edtTipo.text}",
                                                "raca": "${edtRaca.text}",
                                                "sexo": "${_picked}",
                                                "nomePet": "${edtNomePet.text}",
                                                "nomeDono":
                                                    "${edtNomeDono.text}",
                                                "telefone":
                                                    "${edtTelefone.text}",
                                                "descricao": "${edtDesc.text}",
                                                "petPhoto": "$petPhoto"
                                              };

                                              model.savePetData(data).then((a) {
                                                edtDesc.text = "";
                                                edtTelefone.text = "";
                                                edtNomeDono.text = "";
                                                edtNomePet.text = "";
                                                edtRaca.text = "";
                                                edtTipo.text = "";

                                                Future.delayed(
                                                        Duration(seconds: 2))
                                                    .then((a) {
                                                  Flushbar(
                                                    animationDuration: Duration(
                                                        milliseconds: 600),
                                                    icon: Icon(
                                                      Icons.error_outline,
                                                      color: Colors.white,
                                                      size: 26,
                                                    ),
                                                    backgroundColor:
                                                        Colors.green,
                                                    flushbarStyle:
                                                        FlushbarStyle.GROUNDED,
                                                    messageText: Text(
                                                      "Registro enviado com sucesso",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontFamily:
                                                              "WorkSansSemiBold"),
                                                    ),
                                                    duration:
                                                        Duration(seconds: 3),
                                                    flushbarPosition:
                                                        FlushbarPosition.TOP,
                                                  ).show(context).then((a) =>
                                                      Navigator.of(context)
                                                          .pop());
                                                });
                                              });
                                            } else {
                                              autoValidate = true;
                                              setState(() {
                                                heightForm = 1100;
                                                heightScreen = 1250;
                                              });
                                            }
                                          },
                                          child: Text(
                                            "Enviar",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: "BorisBlackBloxx",
                                                color: Colors.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              })),
                        ])),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Future getImage() async {
    File img = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 10);
    String fileName;

    fileName = path.basename(img.path);

    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = storageReference.putFile(img);

    petPhoto = await (await uploadTask.onComplete).ref.getDownloadURL();

    if (uploadTask.isComplete) {
      setState(() {
        Flushbar(
          animationDuration: Duration(milliseconds: 500),
          icon: Icon(
            Icons.check,
            color: Colors.white,
            size: 26,
          ),
          backgroundColor: Theme.ColorsTheme.primaryColor,
          flushbarStyle: FlushbarStyle.GROUNDED,
          messageText: Text(
            "Upload completo",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: "WorkSansSemiBold"),
          ),
          duration: Duration(seconds: 2),
          flushbarPosition: FlushbarPosition.TOP,
        ).show(context);
      });
    }
  }
}
