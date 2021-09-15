import 'package:flutter/material.dart';

showErrorMessage(BuildContext context, String error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        error,
        textAlign: TextAlign.center,
      ),
    ),
  );
}
