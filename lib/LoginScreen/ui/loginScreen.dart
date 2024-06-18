import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  final String email;
  final String password;
  final Function(String) onSavedEmail;
  final Function(String) onSavedPassword;

  LoginScreen({
    required this.email,
    required this.password,
    required this.onSavedEmail,
    required this.onSavedPassword,
  });

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Signed in with Google')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to sign in with Google: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        color: Colors.grey,
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              height: MediaQuery.of(context).size.height * 0.775,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'SignIn into your \n Account',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      initialValue: email,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'johndoe@gmail.com',
                        suffixIcon: Icon(Icons.email),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Email';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        onSavedEmail(value!);
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      initialValue: password,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Password',
                        suffixIcon: Icon(Icons.lock),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.length < 6) {
                          return 'Please Enter Password of min length 6';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        onSavedPassword(value!);
                      },
                    ),
                    SizedBox(height: 5),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(height: 20),
                    Text('Login with'),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.google),
                          onPressed: () {
                            _signInWithGoogle(context);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 35,
                        ),
                        children: [
                          TextSpan(
                            text: 'Don\'t have an account ',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: 'Register Now',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


