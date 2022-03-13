import 'dart:io';
import 'package:flutter/material.dart';
import 'package:genysis/services/auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

class Register extends StatefulWidget {
  final Function? toggleView;
  Register({this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  File? _photo;
  final ImagePicker _picker = ImagePicker();
  //text field state values
  String email = "";
  String password = "";
  String error = "";

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if(pickedFile != null){
        _photo = File(pickedFile.path);
        uploadFile();
      }else{
        print("No Image Selected");
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if(_photo == null) return;
    final filename = basename(_photo!.path);
    final destination = 'files/$filename';

    try{
      final ref = firebase_storage.FirebaseStorage.instance.ref(destination).child('file/');
      await ref.putFile(_photo!);
    }catch(e){
      print('upload failed');
    }
  }

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
              Center(
                child: GestureDetector(
                  onTap: (){
                    _showPicker(context);
                  },
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white,
                    child: _photo != null ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(_photo!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.fitHeight,
                      ),
                    ) : Container(
                      decoration: BoxDecoration(
                        
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(50),
                      ),
                      width: 100,
                      height: 100,
                      child: Icon(Icons.camera_alt,
                      color: Colors.grey[800],
                      ),
                    ),
                  ),
                ),
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
  void _showPicker(context){
    showModalBottomSheet(
      context: context, 
      builder: (BuildContext bc){
        return SafeArea(child: Container(child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Gallery'),
              onTap: (){
                imgFromGallery();
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text("Camera"),
              onTap: (){
                imgFromCamera();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),),);
      });
  }
}
