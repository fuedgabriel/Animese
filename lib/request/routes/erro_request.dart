import 'package:animese/screens/error/connection_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<http.Response> errorConnection(url) async {
  try {
    var response = await http.get(url);
    return response;
  } catch (e) {
    // MaterialPageRoute(builder: (context) => const NoConnection());
    var responseError = http.Response('Erro', 500);
    return responseError;
  }
}