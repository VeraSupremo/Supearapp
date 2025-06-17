import 'package:flutter/material.dart';
//import 'package:flutter_application_1/entidades/creacionVentas.dart';
import '/entidades/venta.dart';
import '../entidades/creacionVentas.dart';

class MercadoPage extends StatefulWidget {
  const MercadoPage({super.key, required this.title});

  final String title;

  @override
  State<MercadoPage> createState() => CreacionDeVentas();
}

class ParcelaCard extends StatelessWidget {
  const ParcelaCard({required this.venta});

  final Venta venta;








  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(venta.imageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10.0),
              ),
              color: const Color.fromARGB(248, 212, 179, 255),
            ),
          ),
          const Divider(height: 2, color: Color.fromARGB(255, 36, 116, 29)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  venta.nombre,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.location_on,
                      size: 12,
                      color: Color.fromARGB(255, 255, 37, 37),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      venta.ubicacion,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: <Widget>[
                    const Icon(Icons.fire_truck, size: 14, color: Colors.green),
                    const SizedBox(width: 2),
                    Text(
                      '${venta.produccionDisponible} Ton',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.money_rounded,
                      size: 32,
                      color: Color.fromARGB(239, 204, 174, 3),
                    ),
                    const SizedBox(width: 2),
                    Text('Precio: \$${venta.precio.toString()}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
