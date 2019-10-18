import 'package:flutter/material.dart';
import 'package:petfind/models/user_model.dart';
import 'package:petfind/ui/SplashScreen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        title: "FindPetsasa",
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
