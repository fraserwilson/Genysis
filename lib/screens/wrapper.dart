import 'package:flutter/material.dart';
import 'package:genysis/screens/authenticate/authenticate.dart';
import 'package:genysis/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return home or authenticate based on auth changes
    return Authenticate();
  }
}