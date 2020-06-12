import 'dart:convert';

Usuario personaFromJson(String str) => Usuario.fromJson(json.decode(str));

String personaToJson(Usuario data) => json.encode(data.toJson());

class Usuario{
  String ap_paterno;
  String ap_materno;
  String nombre;
  String password;
  String telefono;
  String correo;
  String sexo;

  Usuario({
    this.ap_paterno, this.ap_materno, this.nombre, this.password, this.telefono
    , this.correo, this.sexo
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
    ap_paterno: json["ap_paterno"],
    ap_materno: json["ap_materno"],
    nombre: json["nombre"],
    password: json["password"],
    telefono: json["telefono"],
    correo: json["correo"],
    sexo: json["sexo"],
  );

  Map<String, dynamic> toJson() =>{
    "ap_paterno" : ap_paterno,
    "ap_materno" : ap_materno,
    "nombre" : nombre,
    "password":password,
    "telefono":telefono,
    "correo":correo,
    "sexo":sexo,
  };
}

List<Usuario> usuarioFromJson(String strJson){
  final str = json.decode(strJson);
  return List<Usuario>.from(str.map((item){
    print(item);
    return Usuario.fromJson(item);
  }));
}