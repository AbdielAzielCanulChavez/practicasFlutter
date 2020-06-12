import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pruebaexamen/models/productos.dart';
import 'package:pruebaexamen/providers/api_usuario.dart';
import 'package:toast/toast.dart';

import '../main.dart';
import 'contenido.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController correo = TextEditingController();
  TextEditingController passsword = TextEditingController();
  TextEditingController passswordcomprobar = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inicio de sesion"),
      ),
      body: Form(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlutterLogo(
                    size: 400,
                  ),
                  _correo(),
                  _pass(),
                  RaisedButton(
                    child: Text("Loguearme"),
                    onPressed: (){
                      if(correo.text != "" && passsword.text != ""){
                        login(correo.text, passsword.text).then((value){
                          var a = json.decode(value.body);

                          if (a['result'] == "Encontrado") {

                            prefs.id = a['usuario']['id'];
                            prefs.nombre = a['usuario']['nombre'];
                            prefs.token = a['success']['token'];
                            prefs.apellido = a['usuario']['ap_paterno'];


                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Contenido()));
                          }else{
                            Toast.show("Correo o contrasenia erroneas", context, duration: Toast.LENGTH_SHORT);
                          }
                        });
                      }else{
                        Toast.show("Debes llenar todos los campos", context, duration: Toast.LENGTH_SHORT);
                      }
                    },
                  ),
                  GestureDetector(
                    child: Text("Registrarme"),
                    onTap: (){
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MyApp()),
                      );
                    },
                  )
                ],
              ),
            ),) ),
    );
  }


  Widget _correo() {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
      child:TextFormField(

        keyboardType: TextInputType.text,
        controller: correo,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Color.fromRGBO(70, 70, 70, 1),
          fontSize: 16,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromRGBO(255, 255, 255, 1),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(
                  color: Color.fromRGBO(96, 100, 98, 1)
              )
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: BorderSide(color: Color.fromRGBO(220, 220, 220, 1)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: BorderSide(color: Color.fromRGBO(190, 190, 190, 1)),
          ),
          contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 0),
          hintText: "Correo Electronico",
          hintStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black38,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _pass() {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
      child:TextFormField(

        keyboardType: TextInputType.text,
        controller: passsword,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Color.fromRGBO(70, 70, 70, 1),
          fontSize: 16,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromRGBO(255, 255, 255, 1),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(
                  color: Color.fromRGBO(96, 100, 98, 1)
              )
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: BorderSide(color: Color.fromRGBO(220, 220, 220, 1)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: BorderSide(color: Color.fromRGBO(190, 190, 190, 1)),
          ),
          contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 0),
          hintText: "Contrasenia",
          hintStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black38,
            fontSize: 16,
          ),
        ),
      ),
    );
  }


}
