import 'dart:convert';

class Productos{
  int idProducto;
  String descripcion;
  String nombre;
  int precio;
  int id_persona;
  int categoriaProductoId;

  Productos({this.idProducto, this.descripcion, this.nombre,this.id_persona, this.precio, this.categoriaProductoId});

  factory Productos.fromJson(Map<String, dynamic> json) => Productos(
    idProducto: json["id"],
    descripcion: json["descripcion"],
    nombre: json["nombre_producto"],
    precio: json["precio"],
    id_persona: json["persona_id"],
    categoriaProductoId: json["categoria_producto_id"],
  );

  Map<String, dynamic>toJson()=>{
    "id":idProducto,
    "descripcion": descripcion,
    "nombre_producto": nombre,
    "precio":precio,
    "persona_id":id_persona,
    "categoria_producto_id":categoriaProductoId,
  };
}

List<Productos> productosFromJson(String strJson){
  print(strJson);
  final str = json.decode(strJson);
  return List<Productos>.from(str.map((item){
    print(item);
    return Productos.fromJson(item);
  }));
}

String productosToJson(Productos productos){
  final dyn = productos.toJson();
  return json.encode(dyn);
}
