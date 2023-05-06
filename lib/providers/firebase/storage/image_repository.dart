import 'dart:io';
import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';

class ImageRepository {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadFile(File file) async {
    log('POST -- IMAGE');

    Reference ref = storage.ref('/images_events/${getCurrentTime()}');
    UploadTask uploadTask = ref.putFile(file.absolute);

    await Future.value(uploadTask);

    return ref.getDownloadURL();
  }

  Future<void> deleteImage(String url) async {
    Reference ref = storage.refFromURL(url);
    ref.delete();
  }

  String getCurrentTime() {
    DateTime time = DateTime.now();
    return '${time.year}_${time.month}_${time.day}_${time.hour}_${time.minute}_${time.second}_${time.millisecond}';
  }
}
