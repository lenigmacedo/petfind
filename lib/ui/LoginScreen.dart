import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:petfind/models/user_model.dart';
import 'package:petfind/theme/theme.dart' as Theme;
import 'package:petfind/ui/HomeScreen.dart';
import 'package:petfind/ui/RegisterScreen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
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
              height: MediaQuery.of(context).size.height >= 600
                  ? MediaQuery.of(context).size.height
                  : 600,
              child: SafeArea(
                minimum: EdgeInsets.only(top: 60),
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
                      height: 70,
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          width: 350,
                          height: 400,
                          child: Card(
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
                                      validator: _validateEmail,
                                      controller: _emailController,
                                      keyboardType: TextInputType.emailAddress,
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
                                            fontFamily: "BorisBlackBloxx"),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(50, 15, 50, 30),
                                    child: TextFormField(
                                      controller: _passwordController,
                                      validator: _validatePassword,
                                      obscureText: true,
                                      keyboardType: TextInputType.text,
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
                                            fontFamily: "BorisBlackBloxx"),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 40,
                          right: 80,
                          child: ScopedModelDescendant<UserModel>(
                              builder: (context, child, model) {
                            if (model.isLoading) {
                              return Center(
                                child: Container(
                                  child: CircularProgressIndicator(),
                                  padding: EdgeInsets.all(100),
                                ),
                              );
                            }

                            return Container(
                                decoration: BoxDecoration(
                                  color: Theme.ColorsTheme.primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                                child: MaterialButton(
                                  highlightColor: Colors.transparent,
                                  splashColor: Theme.ColorsTheme.primaryColor,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 42.0),
                                    child: Text(
                                      "LOGIN",
                                      style: TextStyle(
                                        fontFamily: "BorisBlackBloxx",
                                        color: Colors.white,
                                        fontSize: 22.0,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      model.signIn(
                                          email: _emailController.text,
                                          onFail: _onFail,
                                          onSucess: _onSucess,
                                          pass: _passwordController.text);
                                    }
                                  },
                                ));
                          }),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: FlatButton(
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                        },
                        child: Text(
                          "Cadastre-se",
                          style: TextStyle(
                              fontFamily: "BorisBlackBloxx",
                              color: Colors.white,
                              fontSize: 25),
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ));
  }

  void _onFail() {
    Flushbar(
      animationDuration: Duration(milliseconds: 600),
      icon: Icon(
        Icons.error_outline,
        color: Colors.white,
        size: 26,
      ),
      backgroundColor: Colors.red,
      flushbarStyle: FlushbarStyle.GROUNDED,
      messageText: Text(
        "Falha ao entrar",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontFamily: "WorkSansSemiBold"),
      ),
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.BOTTOM,
    ).show(context);
  }

  void _onSucess() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  String _validateEmail(String value) {
    if (value.isEmpty) {
      return "Preencha o campo";
    } else {
      return null;
    }
  }

  String _validatePassword(String value) {
    if (value.isEmpty) {
      return "Preencha o campo";
    } else {
      return null;
    }
  }
}
