import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_by_ary/resources/storage_methods.dart';
import 'package:instagram_by_ary/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  //* Sign Up User
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = 'Some Error Occured';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          // file != null
          file.isNotEmpty) {
        //* register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print(cred.user!.uid);

        //* user photo storing in firebase storage
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);
        //* add user data to firestore database

        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          bio: bio,
          photoUrl: photoUrl,
          following: [],
          followers: [],
        );

        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        res = 'Success';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //^ login user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some Error Occured';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential cred = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = 'Success';
      } else {
        res = 'Please fill all the fields';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  signOut() {}
}
