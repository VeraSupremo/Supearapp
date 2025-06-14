import 'package:flutter/material.dart';
import '../Screen/mercado.dart';
import 'venta.dart';

class CreacionDeVentas extends State<MercadoPage> {
  int selectedIndex = 0;

  final List<Venta> _venta = [
    Venta(
      nombre: "Canto del Angel",
      ubicacion: "Marchigue",
      propietario: "Juan Hecheverria",
      cantidadArboles: 8500,
      produccionAnual: 1700,
      produccionDisponible: 200,
      precio: 57142.857,
      imageUrl: 'https://rastro.com/fotos3/2024/02/24/12150484_foto4.jpg',
    ),
    Venta(
      nombre: "Los Qeules",
      ubicacion: "Cauquenes",
      propietario: "Manuel Martinez",
      cantidadArboles: 720,
      produccionAnual: 144,
      produccionDisponible: 42,
      precio: 12000.000,
      imageUrl: 'https://www.turismodeobservacion.com/media/fotografias/campo-ganadero-en-la-region-de-la-araucania-chile-72384-xl.jpg',
    ),
    Venta(
      nombre: "Las liebres",
      ubicacion: "Valparaíso",
      propietario: "Martin vasquez",
      cantidadArboles: 2200,
      produccionAnual: 440,
      produccionDisponible: 3,
      precio: 857.000,
      imageUrl: 'https://andinoblob.blob.core.windows.net/media/filer_public_thumbnails/filer_public/b3/bd/b3bda1aa-bbc9-47e0-8990-ff72cf1c613f/valparaiso.jpg__1440x760_q85_subsampling-2.jpg',
    ),
    Venta(
      nombre: "Ex Fundo el Peral",
      ubicacion: "Parral",
      propietario: "Sergio Masias",
      cantidadArboles: 100,
      produccionAnual: 20,
      produccionDisponible: 0,
      precio: 0,
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYgdQ1IXazX-c70Zwxe9Z5WC43_pdNrui1Rg&s',
    ),
    Venta(
      nombre: "Microlote A",
      ubicacion: "Molina",
      propietario: "Gerardo jimenez",
      cantidadArboles: 100,
      produccionAnual: 20,
      produccionDisponible: 1,
      precio: 285.000,
      imageUrl: 'https://photos.encuentra24.com/t_or_fh_m/f_auto/v1/cl/29/77/30/18/29773018_c17d9c',
    ),
    Venta(
      nombre: "Microlote b",
      ubicacion: "Molina",
      propietario: "Jostin Jimenez",
      cantidadArboles: 100,
      produccionAnual: 20,
      produccionDisponible: 2,
      precio: 571.000,
      imageUrl: 'https://www.ciperchile.cl/wp-content/uploads/campo.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _venta.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Detalles de ${_venta[index].nombre}'),
                    content: Text(
                      'Ubicación: ${_venta[index].ubicacion}\n'
                      'Propietario: ${_venta[index].propietario}\n'
                      'Precio: \$${_venta[index].precio}',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cerrar'),
                      ),
                    ],
                  ),
                );
              },
              child: ParcelaCard(
                venta: _venta[index],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                "¿Desea Vender un producto?",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              content: Text(
                "Recuerda cotizar los valores del producto en tu zona o unirte a un centro de acopio, una vez publicada no podras editar ciertos aspectos como su ubicacion, se precavido",
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Si",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "No",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              backgroundColor: Color.fromARGB(235, 248, 248, 248),
            ),
          );
        },
        backgroundColor: const Color.fromARGB(255, 36, 116, 29),
        child: const Icon(Icons.add, color: Color.fromARGB(255, 255, 253, 253)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.edit, color: Color.fromARGB(255, 243, 239, 7)),
            activeIcon: const Icon(Icons.edit_note, color: Color.fromARGB(255, 36, 116, 29), size: 30),
            label: "Tus Publicaciones",
            backgroundColor: const Color.fromARGB(255, 95, 170, 88),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.store, color: Color.fromARGB(255, 190, 0, 0), size: 30),
            activeIcon: const Icon(Icons.storefront, color: Color.fromARGB(255, 36, 116, 29), size: 30),
            label: "Centro de ventas",
            backgroundColor: const Color.fromARGB(255, 190, 0, 0),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.group, color: Color.fromARGB(255, 111, 0, 255)),
            activeIcon: const Icon(Icons.group_outlined, color: Color.fromARGB(255, 201, 166, 233), size: 30),
            label: "Centro de Acopio",
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          ),
        ],
      ),
    );
  }
}