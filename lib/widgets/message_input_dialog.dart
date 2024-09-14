//import 'dart:ffi';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:youtube_explode_dart/youtube_explode_dart.dart';

final messageProvider = StateProvider((ref) => '');
//final showDialogProvider = StateProvider((ref) => false);

class MessageInputDialog {

  showInputDialog(BuildContext context, WidgetRef ref) {
    String editedValue= ref.watch(messageProvider.notifier).state;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              const Text('Enter URL'),
              TextFormField(
                initialValue: editedValue,
                onChanged: (value) {
                  //ref.read(messageProvider.notifier).state= value;
                  editedValue= value;
                },
                decoration: const InputDecoration(hintText: 'Type your message'),
              )
            ],
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () async {
              },
            ),
          ],
        );
      },

    );
  }
}
