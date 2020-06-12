import 'package:pruebaexamen/actividades/agregar.dart';
import 'package:pruebaexamen/actividades/editar.dart';
import 'package:flutter/material.dart';
import 'package:pruebaexamen/actividades/mostrarcontenidoporid.dart';
import 'package:pruebaexamen/models/productos.dart';
import 'package:pruebaexamen/providers/api_productos.dart';


List <Productos> productoLista = new List<Productos>();
bool banderaProductos = false;
class Contenido extends StatefulWidget {
  @override
  _ContenidoState createState() => _ContenidoState();
}

class _ContenidoState extends State<Contenido> {
  
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    print("hola");
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
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crud lista de ${pref.nombre}"),
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

                  },
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Card(

                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(

                              productosItem.descripcion,
                              style: Theme.of(context).textTheme.subtitle1,

                            ),
                            ButtonBar(
                              children: <Widget>[
                                FlatButton(onPressed: (){
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                        return Editar(producto: productosItem); //aqui van los valores de editar
                                      }));
                                },
                                    child: Icon(Icons.edit)),
                                FlatButton(onPressed: (){
                                  eliminarProducto(productosItem);
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Contenido()));

                                },
                                    child: Icon(Icons.delete_forever))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ):Text("No hay productos");
            return Center(child: Text("Success"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      )),
    );
  }
}
