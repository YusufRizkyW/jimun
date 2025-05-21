import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<Map<String, dynamic>> register({
    required String name,
    String? email,
    required String nohp,
    required String password,
    }) async {
          final url = Uri.parse('http://localhost:8000/api/register');
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
    final url = Uri.parse('http://localhost:8000/api/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nohp': nohp,
        'password': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return {'success': true, 'data': jsonDecode(response.body)};
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
}