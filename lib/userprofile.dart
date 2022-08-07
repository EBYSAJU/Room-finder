import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/login.dart';

class UserProfile extends StatelessWidget{
  const UserProfile({Key? key}) : super(key: key);
  void signout () async {
    await FirebaseAuth.instance.signOut();

  }

  @override
  Widget build(BuildContext context) {
  return(
  Scaffold(
body: SafeArea(
  child: TextButton(
    child: Text('Logout'),
    onPressed: () {
      signout();
     Navigator.pushNamedAndRemoveUntil(
         context, '/login', ModalRoute.withName('/login'));
    },


  ),
),
  )

  );
  }



}