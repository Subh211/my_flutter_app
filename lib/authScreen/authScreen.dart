import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_app/LoginScreen/ui/loginScreen.dart';
import 'package:my_flutter_app/SignupScreen/ui/signupScreen.dart';
import 'package:my_flutter_app/homeScreen/bloc/homeScreen_bloc.dart';
import 'package:my_flutter_app/homeScreen/bloc/homeScreen_event.dart';
import 'package:my_flutter_app/homeScreen/ui/homeScreen.dart';
import 'package:my_flutter_app/services/authServices.dart';



class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String contact = '';
  String name = '';
  bool isLogin = true;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (isLogin) {
        AuthServices.signinUser(email, password, context);
      } else {
        AuthServices.signupUser(email, password, name, contact, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 35,
                    ),
                    children: [
                      TextSpan(
                        text: 'Social',
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: 'X',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isLogin = true;
                        });
                      },
                      child: Container(
                        width: 190,
                        height: 50,
                        decoration: BoxDecoration(
                          color: isLogin ? Colors.white : Colors.red,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              color: isLogin ? Colors.black : Colors.grey,
                              backgroundColor: isLogin ? Colors.white : Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isLogin = false;
                        });
                      },
                      child: Container(
                        width: 182,
                        height: 50,
                        decoration: BoxDecoration(
                          color: isLogin ? Colors.red : Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                              color: isLogin ? Colors.grey : Colors.black,
                              backgroundColor: isLogin ? Colors.red : Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: isLogin ? LoginScreen(
          email: email,
          password: password,
          onSavedEmail: (value) => setState(() => email = value),
          onSavedPassword: (value) => setState(() => password = value),
        ) : SignupScreen(
          email: email,
          password: password,
          name: name,
          contact: contact,
          onSavedEmail: (value) => setState(() => email = value),
          onSavedPassword: (value) => setState(() => password = value),
          onSavedName: (value) => setState(() => name = value),
          onSavedContact: (value) => setState(() => contact = value),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        color: Colors.red,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 30.0,
          child: ElevatedButton(
            onPressed: _submitForm,
            child: Text(
              isLogin ? 'LOGIN' : 'SIGN UP',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


