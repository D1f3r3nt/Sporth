import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShareProvider {
  void shareEvent(String urlImage, String text) async {
    Uint8List imageBytes;

    if (urlImage.contains('http')) {
      final url = Uri.parse(urlImage);
      final response = await http.get(url);
      imageBytes = response.bodyBytes;
    } else {
      final ByteData assetData = await rootBundle.load('image/banners/$urlImage');
      imageBytes = assetData.buffer.asUint8List();
    }

    final temporal = await getTemporaryDirectory();
    final path = '${temporal.path}/image.jpg';
    File(path).writeAsBytesSync(imageBytes);

    final data = XFile(path);
    await Share.shareXFiles([data], subject: 'Mira el evento de Sporth', text: text);
  }
}
