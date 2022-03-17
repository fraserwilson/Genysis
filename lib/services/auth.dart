import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:genysis/models/commonModels/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{

  CurrentUser? _userFromFirebase(User? user){
    return user != null ? CurrentUser(uid: user.uid, name: user.displayName, email: user.email) : null;
  }

  Stream<CurrentUser?> get user{
    return _auth.authStateChanges().map(_userFromFirebase) ;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign in with email and password
  Future signInEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result =  await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebase(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  // sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e)
    {
      print(e.toString());
      print("could not sign out");
      return null;
    }
  }

  Future forgotPassword(String email) async{
    try{
       return await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
      print("Could not reset password");
      return null;
    }
  }

  Future googleSignIn() async{
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;  
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return null;
    }
  }


}