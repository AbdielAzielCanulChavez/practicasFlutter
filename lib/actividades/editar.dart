import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pruebaexamen/actividades/contenido.dart';
import 'package:pruebaexamen/models/categoriaproducto.dart';
import 'package:pruebaexamen/preferencias/shared_preferences.dart';
import 'package:pruebaexamen/providers/api_categoriaproductos.dart';
import 'package:toast/toast.dart';
import 'package:pruebaexamen/models/productos.dart';
import 'package:pruebaexamen/providers/api_productos.dart';

final prefs = new PreferenciasUsuario();

class Editar extends StatefulWidget {

  Editar({Key key, this.producto, this.categoriaproducto});
  Productos producto;
  Categoriaproducto categoriaproducto;

  @override
  _EditarState createState() => _EditarState();

}

Future<List<Categoriaproducto>> categoriaProductos;
Categoriaproducto _currentCategoria;

class _EditarState extends State<Editar> {

  TextEditingController descripcionUpdate = TextEditingController();
  TextEditingController nombreUpdate = TextEditingController();
  TextEditingController precioUpdate = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoriaProductos = getCategoriaProductos();
    descripcionUpdate.text = widget.producto.descripcion;
    nombreUpdate.text = widget.producto.nombre;
    precioUpdate.text = (widget.producto.precio).toString();
    obtenerCategoria();
  }

  obtenerCategoria(){

    categoriaProductos = getCategoriaProductos();

    categoriaProductos.then((value) {
      for(int i = 0; i<value.length; i++) {
        if(value[i].id == widget.producto.categoriaProductoId) {
          _currentCategoria = value[i];
        }
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Registro de lugar"),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlutterLogo(
                  size: 100,
                ),
                _descripcion(),
                _nombre(),
                _precio(),
                _categoriaproducto(),

                RaisedButton(
                  child: Text("Guardar cambios"),  //aqui puede haber un error
                    onPressed: (){
                      if(descripcionUpdate.text != "" && nombreUpdate.text != "" && precioUpdate.text != "" ){

                        Productos productos = Productos(
                          idProducto: widget.producto.idProducto,
                          id_persona: prefs.id,
                          descripcion: descripcionUpdate.text,
                          nombre: nombreUpdate.text,
                          precio: int.parse(precioUpdate.text),
                          categoriaProductoId: _currentCategoria.id,
                        );
                        print(json.encode(productos));
                        editarProducto(productos).then((value){
                          print(value.body);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Contenido()));
                          Toast.show("Producto actualizado", context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                        }).catchError((onError){
                          print(onError);
                        });
                      }else{
                        Toast.show("Debes de llenar todos los campos", context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                      }
                    }
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _categoriaproducto(){
    return Container(
      padding: EdgeInsets.fromLTRB(5, 10, 5, 2),
      child: FutureBuilder<List<Categoriaproducto>>(
        future: categoriaProductos,
        builder: (context, data){
          if(data.connectionState == ConnectionState.done && data.data.isNotEmpty){
            return Container(
              child: DropdownButton(
                value: _currentCategoria,
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
                      _currentCategoria = value;
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
        controller: descripcionUpdate,
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
          hintText: "Nombre del lugar",
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
        controller: nombreUpdate,
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
          hintText: "",
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
        controller: precioUpdate,
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
          hintText: "Longitud (00.0000",
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
