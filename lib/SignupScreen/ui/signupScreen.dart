import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  final String email;
  final String password;
  final String name;
  final String contact;
  final Function(String) onSavedEmail;
  final Function(String) onSavedPassword;
  final Function(String) onSavedName;
  final Function(String) onSavedContact;

  SignupScreen({
    required this.email,
    required this.password,
    required this.name,
    required this.contact,
    required this.onSavedEmail,
    required this.onSavedPassword,
    required this.onSavedName,
    required this.onSavedContact,
  });

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    bool? isChecked = false;
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
                      'Create a new Account',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      initialValue: widget.email,
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
                        widget.onSavedEmail(value!);
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      initialValue: widget.password,
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
                        widget.onSavedPassword(value!);
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      initialValue: widget.name,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        hintText: 'John Doe',
                        suffixIcon: Icon(Icons.person),
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
                          return 'Please Enter Name';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        widget.onSavedName(value!);
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      initialValue: widget.contact,
                      decoration: InputDecoration(
                        labelText: 'Contact',
                        hintText: '1234567890',
                        suffixIcon: Icon(Icons.phone),
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
                          return 'Please Enter Contact';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        widget.onSavedContact(value!);
                      },
                    ),
                Row(
                  children: [
                   Checkbox(value: true, onChanged: (value) {}),

                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 35,
                        ),
                        children: [
                          TextSpan(
                            text: 'I agree with ',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: 'Terms & Conditions',
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
                SizedBox(height: 5),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 35,
                    ),
                    children: [
                      TextSpan(
                        text: 'Already have an Account? ',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign In!',
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
            )
          ],
        ),
      ),
    );
  }
}
