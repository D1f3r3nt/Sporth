import 'dart:io';
import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';

class ImageService {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadFile(File file) async {
    log('POST -- IMAGE');
    
    int bytesOfFile = await sizeOfFile(file);
    
    if (bytesOfFile > 10485760) {
      throw Exception('Peso maximo de 10MB');
    }
    

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

  Future<int> sizeOfFile(File archivo) async {
    if (await archivo.exists()) {
      // Obtener el objeto FileStat para el archivo
      FileStat archivoStat = await archivo.stat();

      // Obtener el tamaño del archivo en bytes
      int pesoEnBytes = archivoStat.size;

      return pesoEnBytes;
    } else {
      throw Exception('El archivo no existe.');
    }
  }
}
