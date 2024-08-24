import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:github_tmdb/features/authentication/models/user_model.dart';
import 'package:github_tmdb/features/authentication/screens/login/login.dart';
import 'package:github_tmdb/features/movie/screens/home/home.dart';
import 'package:github_tmdb/features/movie/screens/navigations/bottom_navigation_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  screenRedirect(BuildContext context) async {
    try {
      if (_auth.currentUser != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const TBottomNavigationBar(),
          ),
        );
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;
      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      return await _auth.signInWithCredential(credentials);
    } on Exception catch (e) {
      throw 'exception->$e';
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw e.toString();
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw e.toString();
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw e.toString();
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<UserModel> getUser() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection("Users")
          .doc(_auth.currentUser!.uid)
          .get();
      return UserModel.fromJson(snapshot);
    } on FirebaseAuthException catch (e) {
      throw e.toString();
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> signoutAccount() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw e.toString();
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> deleteAccount(
      String email, String password, BuildContext context) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        throw 'No user is currently signed in';
      }
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await user.reauthenticateWithCredential(credential);

      await user.delete();

      await FirebaseFirestore.instance
          .collection("Users")
          .doc(user.uid)
          .delete();
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Incorrect Password'),
          ),
        );
      }
      throw e.toString();
    } on FirebaseException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Incorrect Password'),
          ),
        );
      }
      throw e.toString();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Incorrect Password'),
          ),
        );
      }
      throw e.toString();
    }
  }
}
