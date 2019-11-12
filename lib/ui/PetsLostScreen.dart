import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petfind/models/petsModel.dart';
import 'package:petfind/theme/theme.dart' as Theme;
/*aaa*/

class PetsLost extends StatefulWidget {
  @override
  _PetsLostState createState() => _PetsLostState();
}

class _PetsLostState extends State<PetsLost> {
  var pets = <Pets>[];

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
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, top: 5),
                          child: Text(
                            "Pets perdidos",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontFamily: "BorisBlackBloxx"),
                          ),
                        ),
                        Expanded(
                          child: StreamBuilder(
                            stream: Firestore.instance
                                .collection("pets")
                                .snapshots(),
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                case ConnectionState.waiting:
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                default:
                                  return ListView.builder(
                                    itemBuilder: (context, index) {
                                      return CardPet(
                                          snapshot.data.documents[index].data);
                                    },
                                    itemCount: snapshot.data.documents.length,
                                  );
                              }
                            },
                          ),
                        )
                      ],
                    )))));
  }
}

class CardPet extends StatelessWidget {
  final Map<String, dynamic> data;

  CardPet(this.data);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 10, 10),
                child: Center(
                  child: Text(
                    data["nomePet"],
                    style:
                        TextStyle(fontSize: 20, fontFamily: "BorisBlackBloxx"),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                  child: Center(
                      child: (data["petPhoto"] == "null"
                          ? Text(
                              "Pet sem foto",
                              style: TextStyle(
                                  fontSize: 20, fontFamily: "BorisBlackBloxx"),
                            )
                          : Image.network(
                              data["petPhoto"],
                              height: 200,
                              width: 200,
                            )))),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Raça: ",
                      style: TextStyle(
                          fontSize: 18, fontFamily: "BorisBlackBloxx"),
                    ),
                    Text(
                      data["raca"],
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 10, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Sexo do pet: ",
                      style: TextStyle(
                          fontSize: 18, fontFamily: "BorisBlackBloxx"),
                    ),
                    Text(
                      data["sexo"],
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 10, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Tipo do pet: ",
                      style: TextStyle(
                          fontSize: 18, fontFamily: "BorisBlackBloxx"),
                    ),
                    Text(
                      data["tipo"],
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 10, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Nome do dono: ",
                      style: TextStyle(
                          fontSize: 18, fontFamily: "BorisBlackBloxx"),
                    ),
                    Text(
                      data["nomeDono"],
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 10, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Telefone do dono: ",
                      style: TextStyle(
                          fontSize: 19, fontFamily: "BorisBlackBloxx"),
                    ),
                    Expanded(
                      child: Text(
                        data["telefone"],
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 10, 0),
                child: Text(
                  "Descrição do pet: ",
                  style: TextStyle(fontSize: 18, fontFamily: "BorisBlackBloxx"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 10, 20),
                child: Text(
                  data["descricao"],
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
