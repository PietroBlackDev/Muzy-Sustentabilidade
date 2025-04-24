import 'package:flutter/material.dart';

InputDecoration getAuthenticationInputDecoration(String label) {
  return InputDecoration(
    hintText: label,
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.fromLTRB(13, 7, 13, 7),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: const Color.fromARGB(141, 158, 158, 158)),
    ),
  );
}
