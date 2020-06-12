import 'dart:convert';
import 'package:pruebaexamen/models/usuario.dart';
import 'package:http/http.dart' as http;


Future<http.Response> addUser(Usuario persona) async {
  final response = await http.post(
      "http://192.168.1.51:8000/api/registrarPersona",
      headers: {
        "content-type": "application/json",
      },
      body: json.encode(persona));
  print(response.body);
  return response;
}

Future<http.Response> login(String correo, String pass) async {
  Map jsonData = {'correo': correo, 'password': pass};

  final response = await http
      .post("http://192.168.1.51:8000/api/login",
      headers: {
        "content-type": "application/json",
      },
      body: json.encode(jsonData));

  print(response.body);
  return response;
}