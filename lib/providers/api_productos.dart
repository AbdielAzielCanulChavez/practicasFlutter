import 'dart:convert';
import 'package:pruebaexamen/actividades/agregar.dart';
import 'package:pruebaexamen/preferencias/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:pruebaexamen/models/productos.dart';

PreferenciasUsuario pref = PreferenciasUsuario();

Future<List<Productos>> getProductos() async{
  Map jsonData = {'persona_id':pref.id};
  final response = await http.post(
      "http://192.168.1.51:8000/api/obtenerProductosPorPersona",
      headers: {
        "content-type": "application/json",
        "Authorization": "Bearer ${pref.token}",
        "Accept": "aplication.json"
      },
      body: json.encode(jsonData));
  print(response.body);
  return productosFromJson(response.body);
}

Future<http.Response> addProducto(Productos productos) async {

  Map agregar = {
    'descripcion': productos.descripcion,
    'nombre_producto':productos.precio,
    'precio':productos.precio,
    'categoria_producto_id':productos.categoriaProductoId,
    'persona_id': prefs.id,
  };

  final response = await http.post('http://192.168.1.51:8000/api/agregarProducto',
      headers: {
        "content-type": "application/json",
        "Authorization": "Bearer ${pref.token}",
        "Accept": "aplication/json"
      },
      body: json.encode(agregar));
  print(response.body);
  return response;
}

Future<http.Response> editarProducto(Productos editar) async{
  final response = await http.post('http://192.168.1.51:8000/api/editarProducto',
      headers: {
        "content-type": "application/json",
        "Authorization": "Bearer ${pref.token}",
        "Accept": "aplication/json"
      },
      body:  productosToJson(editar));
  return response;
}

Future<http.Response> eliminarProducto(Productos borrar) async{
  final response = await http.post('http://192.168.1.51:8000/api/eliminarProducto',
      headers: {
        "content-type": "application/json",
        "Authorization": "Bearer ${pref.token}",
        "Accept": "aplication/json"
      },
      body:  productosToJson(borrar));
  return response;
}

