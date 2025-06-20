import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Screen/profile.dart';
import 'dart:io';
import 'dart:convert';


class UserPreferences {
  static late UserType _userType;
  static late String _nombreUsuario;
  static String? _profileImagePath;

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final storedType = prefs.getString('userType');
    
    _userType = storedType != null 
        ? UserType.values.firstWhere(
            (e) => e.toString() == storedType,
            orElse: () => UserType.comprador,
          )
        : UserType.comprador;
    _nombreUsuario = prefs.getString('username') ?? 'Camarada Anónimo'; 
    _profileImagePath = prefs.getString('profileImagePath');
  }

  static Future<void> saveUserType(UserType type) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userType', type.toString());
    _userType = type;
  }
  static Future<void> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    _nombreUsuario = username;
  }
  static Future<void> saveProfileImage(String? imagePath) async {
    final prefs = await SharedPreferences.getInstance();
    if(imagePath != null){
      await prefs.setString('profileImagePath', imagePath); // Guardar la ruta de la imagen de perfil
    } else {
      await prefs.remove('profileImagePath'); // Eliminar la ruta de la imagen de perfil si es nula
    }
    _profileImagePath = imagePath; // Actualizar la variable de instancia
    
  }


  static UserType getUserType() {
    return _userType;
  }
  
  static String getUsername() {
    return _nombreUsuario;
  }

  static File? getProfileImage() {
    // Implementación para obtener la imagen de perfil
    // Aquí puedes usar SharedPreferences o cualquier otra forma de almacenamiento
     return _profileImagePath != null ? File(_profileImagePath!) : null;
  }
}