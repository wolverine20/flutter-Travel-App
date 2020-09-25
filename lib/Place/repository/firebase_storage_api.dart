import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseStorageAPI{

  final StorageReference _storageReference = FirebaseStorage.instance.ref();

  Future<StorageUploadTask> uploadFile (String path, File image) async{
    StorageUploadTask storageUploadTask = _storageReference.child(path).putFile(image);

    return storageUploadTask;
  }
}
