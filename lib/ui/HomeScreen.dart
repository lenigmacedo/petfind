import 'package:flutter/material.dart';
import 'package:petfind/models/user_model.dart';
import 'package:petfind/theme/theme.dart' as Theme;
import 'package:petfind/ui/PetsLostScreen.dart';
import 'package:petfind/ui/RegisterLostScreen.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        backgroundColor: Theme.ColorsTheme.primaryColor,
        body: SingleChildScrollView(
            child: Container(
          decoration: BoxDecoration(gradient: Theme.ColorsTheme.gradient),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height >= 600
              ? MediaQuery.of(context).size.height
              : 600,
          child: SafeArea(
              minimum: EdgeInsets.only(top: 50),
              child: ScopedModelDescendant<UserModel>(
                  builder: (context, child, model) {
                var name = model.userData["name"];

                return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(
                        "assets/images/logo.png",
                        fit: BoxFit.fill,
                        width: 130,
                        height: 40,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                        child: Text(
                          name == null
                              ? "Carregando"
                              : "$name, seja bem vindo(a) ao FindPet",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "BorisBlackBloxx"),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PetsLost()));
                        },
                        child: Container(
                            height: 100,
                            width: 300,
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 25, horizontal: 10),
                                  child: Text(
                                    "Feed animais perdidos",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Theme.ColorsTheme.primaryColor,
                                        fontFamily: "BorisBlackBloxx"),
                                  ),
                                ))),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                          height: 100,
                          width: 300,
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 25, horizontal: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterLostScreen()));
                                    },
                                    child: Text(
                                      "Perdeu seu animal?",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Theme.ColorsTheme.primaryColor,
                                          fontFamily: "BorisBlackBloxx"),
                                    ),
                                  ))))
                    ]);
              })),
        )));
  }
}
