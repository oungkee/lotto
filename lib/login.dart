// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart'; //구글 로그인을 위한 패키지.
// import 'dart:async'; //timer 를 사용하기 위함 package
// import 'main.dart';
// import 'package:firebase_core/firebase_core.dart'; //firebase 사용을 위한 패키지.
// import 'package:firebase_auth/firebase_auth.dart';  //구글 로그인 패키지.
//
// class LoginPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _LoginPage();
// }
//
// class _LoginPage extends State<LoginPage> {
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context,snapshot) {
//           if (!snapshot.hasData) {
//             header
//           }
//         },
//     )
//
//   }
// }
