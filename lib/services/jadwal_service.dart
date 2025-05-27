import 'dart:convert';
import 'package:http/http.dart' as http;

class JadwalService {
  static Future<List<Map<String, dynamic>>> fetchJadwal() async {
    try {
      final url = Uri.parse('http://127.0.0.1:8000/api/jadwals');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['data']);
      } else {
        // Bisa log error atau tampilkan pesan
        print('Gagal fetch jadwal: ${response.statusCode} ${response.body}');
        return [];
      }
    } catch (e) {
      print('Error fetch jadwal: $e');
      return [];
    }
  }
}