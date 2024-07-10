import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/api/send_message.dart';

class MessageForm extends ConsumerWidget {
  const MessageForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomTag = ref.watch(roomTagProvider);
    final message = ref.watch(messageProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: "Room Tag"),
            controller: TextEditingController(text: roomTag),
            onChanged: (value) => ref.read(roomTagProvider.notifier).state = value,
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(labelText: "Message"),
            maxLines: 5,
            onChanged: (value) => ref.read(messageProvider.notifier).state = value,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            child: const Text("Send Message"),
            onPressed: () async {
              var respondMessage= await sendMessage(roomTag, message);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(respondMessage)),
              );
            },
          ),
        ],
      ),
    );
  }
}