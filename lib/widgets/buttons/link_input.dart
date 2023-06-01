import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkInput extends StatelessWidget {
  final String text;
  final String url;

  const LinkInput({super.key, required this.text, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final Uri uri = Uri.parse(url);
        
        if (!await launchUrl(uri)) {
          throw Exception('Could not launch $uri');
        }
      },
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
          fontFamily: 'Kanit',
          fontSize: 16.0,
        ),
      ),
    );
  }
}