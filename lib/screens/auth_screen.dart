import 'dart:developer';

import 'package:chat_app_2/widgets/auth_widgets/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AuthScreen extends StatefulWidget {

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;

  void _submitAuthForm(
      String email,
      String password,
      String username,
      bool isLogin,
      BuildContext ctx,
      ) async{
    UserCredential userCredential;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin){
        userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);

      }else {
        userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        await FirebaseFirestore.instance.collection('users').doc(userCredential.user.uid).set({
          'username': username,
          'email': email,
        });
      }
      setState(() {
        _isLoading = false;
      });
    } on FirebaseAuthException catch(err){
      String message = 'An error occurred, please check your credentials';
      if (err.message != null){
        message = err.message;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(message)));
      setState(() {
        _isLoading = false;
      });
    } catch (err){
      log(err.toString());
      setState(() {
        _isLoading = false;
      });
    }

      }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm,_isLoading),
    );
  }
}
