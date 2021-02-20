import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'models/usermodel.dart';
import 'dart:async';
import 'package:clone_app/models/messagemodel.dart';

class Methods
{

  GoogleSignIn _googleSignIn = new GoogleSignIn();
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOut() async
  {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    return await FirebaseAuth.instance.signOut();
  }
  Future<User> getCurrentUser() async
  {
    return await FirebaseAuth.instance.currentUser;
  }

  Future<bool> authenticateUser(User user) async
  {
    QuerySnapshot result = await FirebaseFirestore.instance.collection("users").where("email", isEqualTo: user.email).get();
    final List<DocumentSnapshot> docs = result.docs;
    return docs.length==0?true:false;
  }

  Future<void> uploadData(User user) async
  {

   UserModel model = new UserModel(uid: user.uid, email: user.email, profilePhoto: user.photoURL, name: user.displayName);
    FirebaseFirestore.instance.collection("users").doc(user.uid).set(model.convertToMap(model));
  }
  
  Future<List<UserModel>> getAllUsers(User user) async
  {
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("users").get();
    List<UserModel> l = List<UserModel>();
    for(int i=0; i<qs.docs.length; i++)
      {
        if(qs.docs[i].get('uid')!=user.uid) 
          {
            UserModel model = new UserModel(name: qs.docs[i].get('name'), username: qs.docs[i].get('username'),
            email:qs.docs[i].get('email'), uid: qs.docs[i].get('uid'),profilePhoto: qs.docs[i].get('profile_photo') );
            l.add(model);
          }
      }
      return l;
  }

  Future<void> addMessageToDB(Message message) async
  {
    Map<String, dynamic> m = message.getMap();
    await FirebaseFirestore.instance.collection("messages").doc(message.senderid).collection(message.receiverid).add(m);
    return await FirebaseFirestore.instance.collection("messages").doc(message.receiverid).collection(message.senderid).add(m);
  }
}