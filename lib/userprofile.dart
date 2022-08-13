import 'dart:typed_data';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/firebase_storage.dart';
import 'package:myapp/login.dart';
import 'package:file_picker/file_picker.dart';

class UserProfile extends StatelessWidget{
  const UserProfile({Key? key}) : super(key: key);

  void signout () async {
    await FirebaseAuth.instance.signOut();
  }
  void uploadFile()  async{
    FilePickerResult? result = await FilePicker.platform.pickFiles( type: FileType.custom,
      allowedExtensions: ['jpg','png']);
    if(result!=null){
      PlatformFile file = result.files.first;

    }

  }


  @override
  Widget build(BuildContext context) {
    final Storage storage=Storage();
  return(
  Scaffold(
body: SafeArea(

  child: Column(
  children: [
    TextButton(
    onPressed: (){
signout();
Navigator.pushNamedAndRemoveUntil(
context, '/login', ModalRoute.withName('/login'));
},

        child: Text('Logout')),

    ElevatedButton(onPressed:() async{
      FilePickerResult? result = await FilePicker.platform.pickFiles( type: FileType.custom,
          allowedExtensions: ['jpg','png']);
      if(result!=null){
        final path = result.files.single.bytes;

        String fileName = result.files.single.name;
        print(fileName);
        print(path);
        storage.uploadFile(path, fileName).then((value) => print("done"));

      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No file selected")));
      }



    } , child: Text('upload file'))
  ],



    ),


  ),




));

  }



}