import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'firebase_storage_api.dart';

class FirebaseStorageRepository{
  final __firebaseStorageAPI = FirebaseStorageAPI();
  Future<StorageUploadTask> uploadFile (String path, File image) => __firebaseStorageAPI.uploadFile(path, image);
}