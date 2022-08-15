import 'dart:typed_data';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/firebase_storage.dart';
import 'package:myapp/login.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart' as firebaseCore;

class profile extends StatefulWidget {
  @override
  UserProfile createState() => new UserProfile();
}

class UserProfile extends State<profile> {
  // const UserProfile({Key? key}) : super(key: key);

  void signout() async {
    await FirebaseAuth.instance.signOut();
  }

  void SelectFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'png'],withData: true);

    setState(() {});
    if (result != null) {
      // PlatformFile file = result.files.first;
      imageBytes = result.files.single.bytes;
    }
  }

  PlatformFile? pickedFile;
  Uint8List? imageBytes;

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return (Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    signout();
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/login', ModalRoute.withName('/login'));
                  },
                  child: Text('Logout')),
              ElevatedButton(
                  onPressed: () async {
                    SelectFile();
                  },
                  child: Text('select image')),
              const SizedBox(height: 15),
              ElevatedButton(
                  onPressed: () async {
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(
                            type: FileType.custom,
                        allowedExtensions: ['jpg', 'png','jpeg'],withData: true,
                            allowMultiple: false);
                    if (result != null) {
                      Uint8List? pickedFileBytes = result.files.single.bytes;
                      print(pickedFileBytes);
                      Uint8List? path = result.files.single.bytes;

                      String fileName = result.files.single.name;
                     // print(fileName);
                     // print(path);
                      try{
                        if(path!=null)
                        {
                          await storage.uploadFile(path, fileName).then((value) =>print("done"));
                        }

                      }on firebaseCore.FirebaseException catch(e){
                        print(e);
                      }
                     // storage
                       //   .uploadFile(path!, fileName)
                        //  .then((value) => print("done"));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("No file selected")));
                    }
                  },
                  child: Text('upload file')),
              Container(
                child: imageBytes != null
                    ? Image.memory(
                        imageBytes!,
                        fit: BoxFit.scaleDown,
                        width: MediaQuery.of(context).size.width/5,
                        height: MediaQuery.of(context).size.height / 3,
                      )
                    : Text("select image"),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
