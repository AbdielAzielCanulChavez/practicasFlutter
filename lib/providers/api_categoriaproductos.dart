import 'package:pruebaexamen/preferencias/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:pruebaexamen/models/categoriaproducto.dart';

PreferenciasUsuario pref = PreferenciasUsuario();

Future<List<Categoriaproducto>> getCategoriaProductos() async{
  final response = await http.post(
      "http://192.168.1.51:8000/api/obtenerCatalogoProductos",
      headers: {
        "content-type": "application/json",
        "Authorization": "Bearer ${pref.token}",
        "Accept": "aplication.json"
      });

  print(response.body);
  return CategoriaproductosFromJson(response.body);
}