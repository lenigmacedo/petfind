import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:petfind/models/user_model.dart';
import 'package:petfind/theme/theme.dart' as Theme;
import 'package:petfind/ui/HomeScreen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:email_validator/email_validator.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        backgroundColor: Theme.ColorsTheme.primaryColor,
        body: SingleChildScrollView(
          child: Container(
              decoration: BoxDecoration(gradient: Theme.ColorsTheme.gradient),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height >= 900
                  ? MediaQuery.of(context).size.height
                  : 900,
              child: SafeArea(
                minimum: EdgeInsets.only(top: 80),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.fill,
                      width: 220,
                      height: 60,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Stack(
                      children: <Widget>[
                        ScopedModelDescendant<UserModel>(
                            builder: (context, child, model) {
                          if (model.isLoading) {
                            return Center(
                              child: Container(
                                  height: 600,
                                  width: 350,
                                  child: Card(
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  )),
                            );
                          }
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: 600,
                            width: 350,
                            child: Column(
                              children: <Widget>[
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(50),
                                          child: TextFormField(
                                            validator: _validateName,
                                            controller: _nameController,
                                            keyboardType: TextInputType.text,
                                            textCapitalization:
                                                TextCapitalization.none,
                                            style: TextStyle(
                                                fontFamily: "BorisBlackBloxx",
                                                fontSize: 22,
                                                color: Colors.black),
                                            decoration: InputDecoration(
                                              hintText: "Nome",
                                              hintStyle: TextStyle(
                                                  fontSize: 22,
                                                  fontFamily:
                                                      "BorisBlackBloxx"),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              50, 0, 50, 30),
                                          child: TextFormField(
                                            validator: _validateName,
                                            controller: _surNameController,
                                            keyboardType: TextInputType.text,
                                            textCapitalization:
                                                TextCapitalization.none,
                                            style: TextStyle(
                                                fontFamily: "BorisBlackBloxx",
                                                fontSize: 22,
                                                color: Colors.black),
                                            decoration: InputDecoration(
                                              hintText: "Sobrenome",
                                              hintStyle: TextStyle(
                                                  fontSize: 22,
                                                  fontFamily:
                                                      "BorisBlackBloxx"),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              50, 15, 50, 30),
                                          child: TextFormField(
                                            controller: _emailController,
                                            validator: _validateEmail,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            textCapitalization:
                                                TextCapitalization.none,
                                            style: TextStyle(
                                                fontFamily: "BorisBlackBloxx",
                                                fontSize: 22,
                                                color: Colors.black),
                                            decoration: InputDecoration(
                                              hintText: "Email",
                                              hintStyle: TextStyle(
                                                  fontSize: 22,
                                                  fontFamily:
                                                      "BorisBlackBloxx"),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              50, 15, 50, 30),
                                          child: TextFormField(
                                            obscureText: true,
                                            controller: _passwordController,
                                            validator: _validatePassword,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            textCapitalization:
                                                TextCapitalization.none,
                                            style: TextStyle(
                                                fontFamily: "BorisBlackBloxx",
                                                fontSize: 22,
                                                color: Colors.black),
                                            decoration: InputDecoration(
                                              hintText: "Senha",
                                              hintStyle: TextStyle(
                                                  fontSize: 22,
                                                  fontFamily:
                                                      "BorisBlackBloxx"),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                    ),
                                    child: MaterialButton(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 10.0),
                                        child: Text(
                                          "CADASTRAR",
                                          style: TextStyle(
                                            fontFamily: "BorisBlackBloxx",
                                            color:
                                                Theme.ColorsTheme.primaryColor,
                                            fontSize: 22.0,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          Map<String, dynamic> userData = {
                                            "name": _nameController.text,
                                            "sobrenome":
                                                _surNameController.text,
                                            "email": _emailController.text,
                                          };

                                          model.signUp(
                                              userData: userData,
                                              pass: _passwordController.text,
                                              onSucess: () {
                                                Flushbar(
                                                  animationDuration: Duration(
                                                      milliseconds: 600),
                                                  icon: Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                    size: 26,
                                                  ),
                                                  backgroundColor: Theme
                                                      .ColorsTheme.primaryColor,
                                                  messageText: Text(
                                                    "Usuário criado com sucesso",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontFamily:
                                                            "WorkSansSemiBold"),
                                                  ),
                                                  duration:
                                                      Duration(seconds: 2),
                                                  flushbarPosition:
                                                      FlushbarPosition.BOTTOM,
                                                ).show(context);

                                                Future.delayed(
                                                        Duration(seconds: 1))
                                                    .then((a) {
                                                  UserModel().signIn(
                                                      email:
                                                          _emailController.text,
                                                      pass: _passwordController
                                                          .text,
                                                      onSucess: () {
                                                        Navigator.of(context)
                                                            .pushReplacement(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            HomeScreen()));
                                                      },
                                                      onFail: () {});
                                                });
                                              },
                                              onFail: () {
                                                Flushbar(
                                                  animationDuration: Duration(
                                                      milliseconds: 600),
                                                  icon: Icon(
                                                    Icons.error_outline,
                                                    color: Colors.white,
                                                    size: 26,
                                                  ),
                                                  backgroundColor: Colors.red,
                                                  messageText: Text(
                                                    "Falha ao criar usuário",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontFamily:
                                                            "WorkSansSemiBold"),
                                                  ),
                                                  duration:
                                                      Duration(seconds: 3),
                                                  flushbarPosition:
                                                      FlushbarPosition.BOTTOM,
                                                ).show(context);
                                              });
                                        }
                                      },
                                    ))
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              )),
        ));
  }

  void _onSucess(BuildContext context) {
    Flushbar(
      animationDuration: Duration(milliseconds: 600),
      icon: Icon(
        Icons.check,
        color: Colors.white,
        size: 26,
      ),
      backgroundColor: Theme.ColorsTheme.primaryColor,
      messageText: Text(
        "Usuário criado com sucesso",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontFamily: "WorkSansSemiBold"),
      ),
      duration: Duration(seconds: 2),
      flushbarPosition: FlushbarPosition.BOTTOM,
    ).show(context);

    Future.delayed(Duration(seconds: 1)).then((a) {
      UserModel().signIn(
          email: _emailController.text,
          pass: _passwordController.text,
          onSucess: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomeScreen()));
          },
          onFail: () {});
    });
  }

  void _onFail(BuildContext context) {
    Flushbar(
      animationDuration: Duration(milliseconds: 600),
      icon: Icon(
        Icons.error_outline,
        color: Colors.white,
        size: 26,
      ),
      backgroundColor: Colors.red,
      messageText: Text(
        "Falha ao criar usuário",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontFamily: "WorkSansSemiBold"),
      ),
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.BOTTOM,
    ).show(context);
  }

  String _validateName(String value) {
    String pattern = r'(^[a-zA-ZáàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ\s]*$)';
    RegExp regExp = RegExp(pattern);

    if (value.isEmpty || value == " ") {
      return "Campo obrigatório";
    } else if (!regExp.hasMatch(value)) {
      return "Apenas letras";
    }
    return null;
  }

  String _validateEmail(String value) {
    var validator = EmailValidator.validate(value);

    if (validator) {
      return null;
    } else {
      return "Email inválido";
    }
  }

  String _validatePassword(String value) {
    if (value.isEmpty) {
      return "Campo obrigatório";
    } else if (value.length < 6) {
      return "Senha muito curta";
    } else {
      return null;
    }
  }
}
