import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pruebaexamen/models/categoriaproducto.dart';
import 'package:pruebaexamen/models/productos.dart';
import 'package:pruebaexamen/preferencias/shared_preferences.dart';
import 'package:pruebaexamen/providers/api_categoriaproductos.dart';
import 'package:pruebaexamen/providers/api_productos.dart';
import 'package:toast/toast.dart';
import 'contenido.dart';

final prefs = new PreferenciasUsuario();

class Agregarproducto extends StatefulWidget {
  @override
  _AgregarproductoState createState() => _AgregarproductoState();
}

final _formKey = GlobalKey<FormState>();

Future<List<Categoriaproducto>> productosCategoria;
Categoriaproducto _currentProductos;



class _AgregarproductoState extends State<Agregarproducto> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentProductos = null;
    productosCategoria = getCategoriaProductos();
  }



  TextEditingController descripcion = TextEditingController();
  TextEditingController nombre = TextEditingController();
  TextEditingController precio = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar producto"),
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                return Contenido();
              }));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.close),
            ),
          ),
        ],
      ),
      body: Form(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlutterLogo(
                      size: 100,
                    ),

                    _descripcion(),
                    _nombre(),
                   _precio(),
                    selectProductos(),

                    RaisedButton(
                      child: Text("Agregar producto"),
                      onPressed: (){
                      if(descripcion.text != "" && nombre.text != "" && precio.text != ""){
                         Productos productos = Productos(
                          descripcion: descripcion.text,
                            nombre: nombre.text,
                            precio: int.parse(precio.text),
                           categoriaProductoId: _currentProductos.id,
                          );
                         addProducto(productos).then((value){
                           print(value.body);
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Contenido()));
                           Toast.show("producto agregado correctamente", context, duration: Toast.LENGTH_SHORT);
                         }).catchError((onError){
                           print(onError);
                         });
                        }else{
                        Toast.show("Debes de llenar todos los campos", context, duration: Toast.LENGTH_SHORT);
                      }
                      },
                    ),
                  ],
                ),
              ),) ),
    );
  }

  Widget selectProductos(){

    return Container(
      padding: EdgeInsets.fromLTRB(5, 10, 5, 2),
      child: FutureBuilder<List<Categoriaproducto>>(
        future: productosCategoria,
        builder: (context, data){
          if(data.connectionState == ConnectionState.done && data.data.isNotEmpty){
            return Container(
              child: DropdownButton(
                value: _currentProductos,
                items: data.data.map(
                        (categoriaproductos) => DropdownMenuItem<Categoriaproducto>(
                      child: Column(
                        children: <Widget>[
                          Text(
                            categoriaproductos.descripcion,
                          ),
                        ],
                      ),
                      value: categoriaproductos,
                    )
                ).toList(),
                onChanged: (value){
                  setState(() {
                    if(value != null){

                      _currentProductos = value;
                      print(value.id);
                      print(value.descripcion);
                    }
                  });
                },
                hint: Row(
                  children: <Widget>[
                    Text('Categoria productos',
                    ),
                  ],
                ),
              ),
            );
          }
          return CircularProgressIndicator(
            backgroundColor: Colors.transparent,
          );
        },
      ),
    );
  }

  Widget _descripcion() {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
      child:TextFormField(

        keyboardType: TextInputType.text,
        controller: descripcion,
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
          hintText: "Descripcion del producto",
          hintStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black38,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _nombre() {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
      child:TextFormField(

        keyboardType: TextInputType.text,
        controller: nombre,
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
          hintText: "Nombre del producto",
          hintStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black38,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _precio() {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
      child:TextFormField(

        keyboardType: TextInputType.text,
        controller: precio,
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
          hintText: "Precio (00.00)",
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
