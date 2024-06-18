import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_app/authScreen/authScreen.dart';
import 'package:my_flutter_app/homeScreen/bloc/homeScreen_bloc.dart';
import 'package:my_flutter_app/homeScreen/bloc/homeScreen_event.dart';
import 'package:my_flutter_app/homeScreen/ui/homeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SocialX',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BlocProvider(
              create: (context) => NewsBloc()..add(FetchNews()),
              child: NewsScreen(),
            );
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}




