import 'package:flutter/material.dart';
import 'package:sporth/utils/utils.dart';

class Snackbar {
  static void errorSnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error,
              color: ColorsUtils.white,
            ),
            const SizedBox(width: 10),
            Flexible(child: Text(text)),
          ],
        ),
      ),
    );
  }

  static void correctSnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.done,
              color: ColorsUtils.white,
            ),
            const SizedBox(width: 10),
            Flexible(child: Text(text)),
          ],
        ),
      ),
    );
  }
}
