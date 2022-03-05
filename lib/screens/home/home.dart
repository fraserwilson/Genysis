import 'package:flutter/material.dart';
import 'package:genysis/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("GENYSIS"),
        elevation: 0.0,
        actions: [
          TextButton.icon(onPressed: () async {
            await _auth.signOut();
          }, 
          icon: Icon(Icons.person,color: Colors.white,), 
          label: Text("Logout", style: TextStyle(color: Colors.white),)
          )
        ],
      ),
    );
  }
}