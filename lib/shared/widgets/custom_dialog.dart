// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../../state_util.dart';

Future showCustomDialog(
    {required String dialog}) async {
  return showDialog(
    context: globalContext,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Alert!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              dialog,
              style: const TextStyle(fontSize: 22, color: Colors.black),
            ),
          ],
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text('Close'),
            ),
          ),
        ],
      );
    },
  );
}
