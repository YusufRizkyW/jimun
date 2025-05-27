import 'package:flutter/material.dart';
import '../services/antrian_service.dart' as antrian_service;
import 'package:google_fonts/google_fonts.dart';
import 'antrian_detail_screen.dart'; // Pastikan path ini sesuai

class AntrianScreen extends StatefulWidget {
  const AntrianScreen({super.key});

  @override
  State<AntrianScreen> createState() => _AntrianScreenState();
}

class _AntrianScreenState extends State<AntrianScreen> {
  List<Map<String, dynamic>> antrianList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAntrian();
  }

  Future<void> fetchAntrian() async {
    final data = await antrian_service.AntrianService.fetchAntrian();
    setState(() {
      antrianList = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //navbar bawah
      bottomNavigationBar: Container(
  height: 50,
  color: Colors.teal, 
),

      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'JiMun',
                    style: GoogleFonts.aclonica(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Antrian Online',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : antrianList.isEmpty
                        ? _buildKosong()
                        : ListView.builder(
                            itemCount: antrianList.length,
                            itemBuilder: (context, index) {
                              final item = antrianList[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => AntrianDetailScreen(
                                        nomorAntrian: item['nomor_antrian'] ?? 0,
                                        nama: item['nama'] ?? '-',
                                        nik: item['nik'] ?? '-',
                                        tanggalLahir: item['tanggal_lahir']?.toString().substring(0, 10) ?? '-',
                                        jenisImunisasi: item['jenis_imunisasi'] ?? '-',
                                        tanggalPelayanan: item['tanggal_pelayanan'] ?? '-',
                                        lokasi: item['lokasi'] ?? '-',
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 30,
                                              backgroundColor: Colors.amber,
                                              child: Text(
                                                item['nomor_antrian']?.toString() ?? '-',
                                                style: const TextStyle(fontSize: 24, color: Colors.black),
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Nama : ${item['nama'] ?? '-'}"),
                                                  Text("NIK : ${item['nik'] ?? '-'}"),
                                                  Text("Tanggal Lahir : ${item['tanggal_lahir']?.toString().substring(0, 10) ?? '-'}"),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKosong() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_busy, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Belum ada antrian terdaftar',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
