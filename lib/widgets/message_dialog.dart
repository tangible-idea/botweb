import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageDialog extends StatefulWidget {
  @override
  _MessageDialogState createState() => _MessageDialogState();

  // The callback function with data you want to return -------|
  final Function(String value) onConfirm;      // <------------|
  final String initalString;

  const MessageDialog({
    Key? key,
    required this.onConfirm,
    required this.initalString
  }) : super(key: key);
}

class _MessageDialogState extends State<MessageDialog> {
  String result = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          const Text('Enter URL'),
          TextFormField(
            initialValue: widget.initalString,
            onChanged: (value) {
              //ref.read(messageProvider.notifier).state= value;
              result= value;
            },
            decoration: const InputDecoration(hintText: 'Type your message'),
          ),
          ElevatedButton(
            onPressed: () {
              // callback, but if result is empty, return the initial value.
              widget.onConfirm(result=="" ? widget.initalString : result);
              Navigator.pop(context);
            },
            child: const Text('confirm'),
          ),
        ],
      ),
    );
  }
}