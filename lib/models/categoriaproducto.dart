import 'dart:convert';

class Categoriaproducto{

  int id;
  String descripcion;

  Categoriaproducto({
    this.id,
    this.descripcion,
  });

  factory Categoriaproducto.fromJson(Map<String, dynamic> json) => Categoriaproducto(
    id: json["id"],
    descripcion: json["descripcion"],
  );

  Map<String, dynamic> toJson() => {
    "id":id,
    "descripcion":descripcion,
  };
}
List<Categoriaproducto> CategoriaproductosFromJson(String strJson) {
  final str = json.decode(strJson);
  return List<Categoriaproducto>.from(str.map((item) {
    print(item);

    return Categoriaproducto.fromJson(item);
  }));
}

String CategoriaproductosToJson(Categoriaproducto data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}
