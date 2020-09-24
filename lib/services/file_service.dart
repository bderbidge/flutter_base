import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import "dart:async";
import 'interfaces/i_file_service.dart';

class FileService implements IFileService {
  final String storagePath = "docs";
  final _storage = FirebaseStorage.instance;
  Future<StorageUploadTask> uploadFile(
      File file, String userID, String propertyID, FileType type) async {
    String filename = basename(file.path);
    var path = storagePath + "/" + userID + "/" + propertyID + "/" + filename;
    final StorageUploadTask uploadTask = _storage.ref().child(path).putFile(
          file,
          StorageMetadata(
            contentLanguage: 'en',
            customMetadata: <String, String>{'activity': 'test'},
          ),
        );

    return uploadTask;
  }
}
