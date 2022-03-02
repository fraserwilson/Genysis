import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:genysis/models/commonModels/user.dart';
import 'package:genysis/screens/wrapper.dart';
import 'package:genysis/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<CurrentUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home:Wrapper()
        ),
    );
  }
}
