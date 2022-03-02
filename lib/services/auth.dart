import 'package:firebase_auth/firebase_auth.dart';
import 'package:genysis/models/commonModels/user.dart';

class AuthService{

  CurrentUser? _userFromFirebase(User? user){
    return user != null ? CurrentUser(uid: user.uid, name: user.displayName, email: user.email) : null;
  }

  Stream<CurrentUser?> get user{
    return _auth.authStateChanges().map(_userFromFirebase) ;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign in anon
  Future signInAnon() async{
    try{
     UserCredential result =  await _auth.signInAnonymously();
     User? user = result.user;
     return _userFromFirebase(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

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


}