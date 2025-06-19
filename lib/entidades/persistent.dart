import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Screen/profile.dart';

class UserPreferences {
  static late UserType _userType;
  static late String _nombreUsuario;

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
  static UserType getUserType() {
    return _userType;
  }
  static String getUsername() {
    return _nombreUsuario;
  }
}