import 'package:chorebuddies/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore db = Firestore.instance;

  Stream<FirebaseUser> user;
  PublishSubject loading = PublishSubject();
  CollectionReference activities;
  User currentUser;

  AuthService() {
    user = _auth.onAuthStateChanged;
  }

  Future<FirebaseUser> googleSignIn() async {
    loading.add(true);

    GoogleSignInAccount googleUser;
    GoogleSignInAuthentication googleAuth;
    FirebaseUser user;

    try {
      googleUser = await _googleSignIn.signIn();
      googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      user = (await _auth.signInWithCredential(credential)).user;

      await updateUserData(user);
    } catch (error) {
      print("There was a signin error $error");

      loading.add(false);

      return null;
    }

    loading.add(false);

    print("signed in " + user.displayName);

    return user;
  }

  Future<void> updateUserData(FirebaseUser user) async {
    DocumentReference ref = db.collection('users').document(user.uid);
    currentUser = User.of(user);

    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    }, merge: true);
  }

  void signOut() {
    _googleSignIn.signOut();
    _auth.signOut();
  }
}

final AuthService authService = AuthService();
