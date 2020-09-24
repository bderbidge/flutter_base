import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class IFileService {
  Future<StorageUploadTask> uploadFile(
      File file, String userID, String propertyID, FileType type);
}
