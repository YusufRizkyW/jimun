import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AntrianService {
  static Future<Map<String, dynamic>> daftarAntrian({
    required String nik,
    required String nama,
    required String tanggalLahir,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      return {'success': false, 'message': 'Token tidak ditemukan. Silakan login ulang.'};
    }

    final url = Uri.parse('http://18.142.213.110/api/antrians');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'nik': nik,
        'nama': nama,
        'tanggal_lahir': tanggalLahir,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return {'success': true, 'data': jsonDecode(response.body)};
    } else {
      String message = 'Pendaftaran gagal';
      try {
        final body = jsonDecode(response.body);
        if (body is Map && body.containsKey('message')) {
          message = body['message'];
        }
      } catch (_) {}
      return {'success': false, 'message': message};
    }
  }

  static Future<List<Map<String, dynamic>>> fetchAntrian() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) return [];

    final url = Uri.parse('http://18.142.213.110/api/antrians');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data['data']);
    } else {
      return [];
    }
  }
}