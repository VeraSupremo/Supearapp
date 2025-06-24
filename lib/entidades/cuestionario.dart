import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
//import 'cuestionario.json';

class CuestionarioPage extends StatefulWidget {
  const CuestionarioPage({super.key});

  @override
  _CuestionarioPageState createState() => _CuestionarioPageState();
}

class _CuestionarioPageState extends State<CuestionarioPage> {
  Map<String, dynamic> cuestionarioData = {};
  bool _isLoading = true;
  String email = '';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadQuestionnaireData();
  }

  Future<void> _loadQuestionnaireData() async {
    try {
      String jsonString = await rootBundle.loadString('lib/entidades/cuestionario.json');
      Map<String, dynamic> data = jsonDecode(jsonString);
      setState(() {
        cuestionarioData = data;
        _isLoading = false;
      });
    } catch (e) {
      print('Error al cargar el cuestionario: $e');
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al cargar el cuestionario')),
      );
    }
  }

  Widget _buildQuestionSection(String sectionTitle, List<dynamic> questions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            sectionTitle,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ...questions.map((question) => _buildQuestionItem(question)).toList(),
      ],
    );
  }

  Widget _buildQuestionItem(Map<String, dynamic> question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question['titulo'],
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              question['min'],
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              question['max'],
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(6, (index) {
            return IconButton(
              icon: Icon(
                index <= question['valor'] ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  question['valor'] = index;
                });
              },
            );
          }),
        ),
        const Divider(thickness: 1),
        const SizedBox(height: 16),
      ],
    );
  }

  Future<void> _sendEmail() async {
    if (!_formKey.currentState!.validate()) return;

    // Construir el cuerpo del correo con las respuestas
    String body = "Correo del usuario: $email\n\n";
    body += "Respuestas del cuestionario:\n\n";

    cuestionarioData.forEach((section, questions) {
      body += "$section:\n";
      for (var question in questions) {
        body += "- ${question['titulo']}: ${question['valor']} estrellas\n";
      }
      body += "\n";
    });

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'martiniverinirx@gmail.com', // Reemplaza con tu correo
      queryParameters: {'subject': 'Resultados del cuestionario', 'body': body},
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir el cliente de correo')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Cuestionario de Satisfacción')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  hintText: 'ejemplo@correo.com',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu correo';
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return 'Correo no válido';
                  }
                  return null;
                },
                onChanged: (value) => email = value,
              ),
              const SizedBox(height: 30),

              if (cuestionarioData['usabilidad'] != null)
                _buildQuestionSection(
                  'Usabilidad',
                  cuestionarioData['usabilidad'],
                ),

              if (cuestionarioData['contenido'] != null)
                _buildQuestionSection(
                  'Contenido',
                  cuestionarioData['contenido'],
                ),

              if (cuestionarioData['compartir'] != null)
                _buildQuestionSection(
                  'Compartir',
                  cuestionarioData['compartir'],
                ),

              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  onPressed: _sendEmail,
                  child: const Text('Enviar Cuestionario'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
