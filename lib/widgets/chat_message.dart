import 'package:flutter/material.dart';
import 'package:sporth/utils/utils.dart';

class ChatMessage extends StatelessWidget {
  final bool ourMessage;
  final String message;

  const ChatMessage({
    super.key,
    required this.ourMessage,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          if (ourMessage) const Expanded(child: SizedBox()),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            constraints: BoxConstraints(
              maxWidth: size.width * 0.6,
            ),
            decoration: BoxDecoration(
              gradient: ourMessage ? EffectUtils.linearBlues : EffectUtils.linearGreys,
              borderRadius: BorderRadius.only(
                bottomLeft: const Radius.circular(8.0),
                bottomRight: const Radius.circular(8.0),
                topLeft: ourMessage ? const Radius.circular(8.0) : const Radius.circular(30.0),
                topRight: ourMessage ? const Radius.circular(30.0) : const Radius.circular(8.0),
              ),
            ),
            padding: EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              right: ourMessage ? 20.0 : 8.0,
              left: ourMessage ? 8.0 : 20.0,
            ),
            child: Text(
              message,
              style: TextUtils.kanit_18_black,
            ),
          ),
          if (!ourMessage) const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
