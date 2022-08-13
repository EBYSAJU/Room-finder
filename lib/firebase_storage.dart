import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;
import 'package:firebase_core/firebase_core.dart' as firebaseCore;
class Storage{
  final firebaseStorage.FirebaseStorage storage=firebaseStorage.FirebaseStorage.instance;
  Future<void>uploadFile(final path, String fileName) async
  {
 //File file=File(path);
 try{
   await storage.ref('test/$fileName').putData(path);
 }on firebaseCore.FirebaseException catch(e){
   print(e);
 }
  }
}
