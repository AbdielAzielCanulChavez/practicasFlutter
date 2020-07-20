import 'package:pruebaexamen/actividades/agregar.dart';
import 'package:pruebaexamen/actividades/editar.dart';
import 'package:flutter/material.dart';
import 'package:pruebaexamen/preferencias/shared_preferences.dart';
import 'package:pruebaexamen/actividades/mostrarcontenidoporid.dart';
import 'package:pruebaexamen/models/categoriaproducto.dart';
import 'package:pruebaexamen/models/productos.dart';
import 'package:pruebaexamen/providers/api_categoriaproductos.dart';
import 'package:pruebaexamen/providers/api_productos.dart';



List <Productos> productoLista = new List<Productos>();
bool banderaProductos = false;
class Contenido extends StatefulWidget {

  Contenido({Key key,this.producto, this.categoriaproducto}); //esto puede tener error
  Categoriaproducto categoriaproducto; //esto puede tener error
  Productos producto; //esto puede tener error
  @override
  _ContenidoState createState() => _ContenidoState();
}

Future<List<Categoriaproducto>> categoriaProductos; //esto puede tener error
Categoriaproducto _currentCategoria;  //esto puede tener error

class _ContenidoState extends State<Contenido> {
  
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    print("hola");
    obtenerCategoria();
   obtenerProductos();
  }
  
  obtenerProductos() async{
    print("fsfsfasfsa");
    productoLista = await getProductos();
    print(productoLista.length);

    if(productoLista.length > 0){
      setState(() {
        banderaProductos = true;
      });


    }else{
      setState(() {
        banderaProductos = false;
      });

    }
    
  }


  //esto puede tener error
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
  //esto puede tener error
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crud lista del usuario"), //aqui se le agrega ${pref.nombre}
        actions: <Widget>[
          GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return Agregarproducto();
                }));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Icon(Icons.add),
              )),
        ],
      ),
      body: SafeArea(
          child: FutureBuilder(
        future: getProductos(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text(snapshot.error.toString())
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            var response = snapshot.data as List<Productos>;
            return  banderaProductos? ListView.builder(

              itemCount: response.length,
              itemBuilder: (context, position) {
                var productosItem = response[position];

                return GestureDetector(
                  onLongPress: () {

                  },
                  onTap: () {

                    //esto puede tener error
                    AlertDialog(
                      title: Text('Producto'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text('Nombre producto: ${productosItem.nombre}'),
                            Text('Descripcion del producto: ${productosItem.descripcion}'),
                            Text('Precio del producto: ${productosItem.precio}'),
                            Text('Categoria del producto: ${_currentCategoria.descripcion}'),

                          ],
                        ),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Cerrar'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                    //aqui puede tener error

                  },
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Card(

                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[

                            Text(productosItem.nombre, style: Theme.of(context).textTheme.title,),
                            Text(productosItem.descripcion,style: Theme.of(context).textTheme.subtitle1,),

                            ButtonBar(
                              children: <Widget>[
                                FlatButton(onPressed: (){
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                        return Editar(producto: productosItem); //aqui van los valores de editar
                                      }));
                                },
                                    child: Icon(Icons.edit, color: Colors.green,)),
                                FlatButton(onPressed: (){
                                  eliminarProducto(productosItem);
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Contenido()));

                                },
                                    child: Icon(Icons.delete_forever, color: Colors.red,))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ):Center(// esto puede tener error
              child: Text("No hay datos"),  //si tiene error pones :Text("No hay productos");
            );
            return Center(child: Text("Success"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      )),
    );
  }
}
