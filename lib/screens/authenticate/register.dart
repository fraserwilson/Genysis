import 'package:flutter/material.dart';
import 'package:genysis/services/auth.dart';

class Register extends StatefulWidget {
  final Function? toggleView;
  Register({this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  //text field state values
  String email = "";
  String password = "";
  String error = "";
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Register to Genysis'),
        actions: [
          TextButton.icon(
              onPressed: () {
                widget.toggleView!();
              },
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: Text(
                "Sign In",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.02, horizontal: width * 0.1),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "EMAIL"),
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "PASSWORD"),
                validator: (val) => val!.length < 6
                    ? 'Enter a password longer than 6 characters'
                    : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    dynamic result = await _auth.registerWithEmailAndPassword(
                        email, password);
                    if (result == null) {
                      setState(() {
                        error = "Please supply a valid email and password";
                      });
                    }
                  }
                },
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: height * 0.012,
              ),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
