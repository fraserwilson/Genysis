import 'package:flutter/material.dart';
import 'package:genysis/models/commonModels/user.dart';
import 'package:genysis/screens/authenticate/authenticate.dart';
import 'package:genysis/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CurrentUser?>(context);
    print(user);
    if(user == null){
      return Authenticate();
    }
    else{
      return Home();
    }
    //return home or authenticate based on auth changes

  }
}