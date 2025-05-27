import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<Map<String, dynamic>> register({
    required String name,
    String? email,
    required String nohp,
    required String password,
    }) async {
          final url = Uri.parse('http://18.142.213.110/api/register');
          final response = await http.post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'name': name,
              if (email != null && email.isNotEmpty) 'email': email,
              'nohp': nohp,
              'password': password,
            }),
          );

        if (response.statusCode == 200 || response.statusCode == 201) {
          return {'success': true, 'data': jsonDecode(response.body)};
        } else {
          // Coba ambil pesan error dari response
          String message = 'Registrasi gagal';
          try {
              final body = jsonDecode(response.body);
              if (body is Map && body.containsKey('message')) {
                message = body['message'];
              }
            } catch (_) {}
            return {'success': false, 'message': message};
        }
    }

  


  static Future<Map<String, dynamic>> login({
    required String nohp,
    required String password,
  }) async {
    final url = Uri.parse('http://18.142.213.110/api/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nohp': nohp,
        'password': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      // Simpan token ke SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', data['token']); // pastikan key 'token' sesuai dengan response API-mu
      return {'success': true, 'data': data};
    } else {
      String message = 'Login gagal';
      try {
        final body = jsonDecode(response.body);
        if (body is Map && body.containsKey('message')) {
          message = body['message'];
        }
      } catch (_) {}
      return {'success': false, 'message': message};
    }
  }




  static Future<bool> logout({required String token}) async {
    try {
      final url = Uri.parse('http://18.142.213.110/api/logout');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Logout error: $e');
      return false;
    }
  }
}