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
  Stream<Map<String, dynamic>> profile;
  PublishSubject loading = PublishSubject();
  CollectionReference activities;
  User currentUser;

  AuthService() {
    user = _auth.onAuthStateChanged;

    profile = user.switchMap((FirebaseUser u) {
      print("user is $u");

      if (u != null) {
        return db
            .collection('users')
            .document(u.uid)
            .snapshots()
            .map((snap) => snap.data);
      } else {
        return Stream.value({});
      }
    });
  }

  Future<FirebaseUser> googleSignIn() async {
    loading.add(true);

    GoogleSignInAccount googleUser;
    GoogleSignInAuthentication googleAuth;

    try {
      googleUser = await _googleSignIn.signIn();
      googleAuth = await googleUser.authentication;
    } catch (error) {
      print("There was a signin error $error");
      loading.add(false);
      return null;
    }

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;

    await updateUserData(user);

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
    _auth.signOut();
    _googleSignIn.signOut();
  }
}

final AuthService authService = AuthService();
