import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:health_app/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  // final String _baseUrl = 'http://localhost:3000/auth/login'; // para iphone
  final String _baseUrl = 'http://10.0.2.2:3000/auth/login'; // para android

  // Instancia para el almacenamiento seguro
  final _storage = const FlutterSecureStorage(); // <--- AÑADIDO

  // Clave para guardar el token
  static const String _tokenKey = 'jwt_token';

  // Guarda el token en el almacenamiento seguro
  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  // Recupera el token del almacenamiento seguro
  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  // Elimina el token al cerrar sesion
  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }

  Future<String?> login(User user) async {
    // Ahora retorna un String? (el token)
    try {
      final String requestBody = jsonEncode(user.toJson());
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: requestBody,
      );

      if (response.statusCode == 201) {
        // si el login es exitoso
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // Extraemos el token del JSON de respuesta
        final String token = responseData['accessToken'];

        // Guardar el token de forma segura
        await saveToken(token);

        return token; // Retornamos el token
      } else {
        print('Error en la API: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error de conexión: $e');
      return null;
    }
  }
}
