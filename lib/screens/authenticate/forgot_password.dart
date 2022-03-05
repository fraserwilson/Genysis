import 'package:flutter/material.dart';
import 'package:genysis/services/auth.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final AuthService _auth = AuthService();

  @override
  void dispose() {
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Reset Password"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.02, horizontal: width * 0.1),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Recieve an email to\nreset your password",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              TextFormField(
                controller: emailController,
                cursorColor: Colors.blue,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(labelText: "Email"),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email == null ? "Enter a valid email" : null,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  _auth.forgotPassword(emailController.text.trim());
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(height * 0.1)),
                icon: Icon(Icons.email_outlined),
                label: Text(
                  "Reset password",
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
