import 'dart:developer';
import 'dart:io';

import 'package:chat_app_2/widgets/image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading);

  final bool isLoading;
  final void Function(
    String email,
    String password,
    String username,
    File image,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  File _imageFile;
  _pickedImage (File _image){
      _imageFile = _image;
  }
  final _formKey = GlobalKey<FormState>();

  bool _isLogin = true;

  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  _trySubmit() {
    if (_imageFile == null && !_isLogin){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Pick a photo')));
      return;
    }
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(_userEmail.trim(), _userPassword.trim(), _userName.trim(),_imageFile,
          _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!_isLogin) UserImagePicker(_pickedImage),
                TextFormField(
                  key: ValueKey('email'),
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _userEmail = value;
                  },
                  decoration: InputDecoration(labelText: 'Email Address'),
                  keyboardType: TextInputType.emailAddress,
                ),
                if (!_isLogin)
                  TextFormField(
                    key: ValueKey('username'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 4) {
                        return 'Please enter at least 4 characters.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userName = value;
                    },
                    decoration: InputDecoration(labelText: 'Username'),
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  validator: (value) {
                    if (value.isEmpty || value.length < 7) {
                      return 'Please enter at least 7 characters.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _userPassword = value;
                  },
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(
                  height: 12.0,
                ),
                if (widget.isLoading) CircularProgressIndicator(),
                if (!widget.isLoading)
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                          Theme.of(context).buttonTheme.shape),
                    ),
                    onPressed: _trySubmit,
                    child: Text(_isLogin ? 'login' : 'Sign up'),
                  ),
                if (!widget.isLoading)
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin
                          ? 'Create New Account'
                          : 'Already have an account?'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
