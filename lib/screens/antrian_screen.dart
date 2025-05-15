import 'package:flutter/material.dart';
import '../models/antrian_data.dart';


class AntrianScreen extends StatelessWidget {
  final bool adaAntrian;
  final int nomorAntrian;
  final String nama;
  final String nik;
  final String tanggalLahir;
  final String jenisImunisasi;
  final String tanggalPelayanan;
  final String lokasi;

  const AntrianScreen({
    super.key,
    this.adaAntrian = false,
    this.nomorAntrian = 0,
    this.nama = '',
    this.nik = '',
    this.tanggalLahir = '',
    this.jenisImunisasi = '',
    this.tanggalPelayanan = '',
    this.lokasi = '',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'JiMun',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              const Text(
                'Antrian Online',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),

              // Konten
              Expanded(
                child: adaAntrian ? _buildAntrianCard() : _buildKosong(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget jika belum ada antrian
  Widget _buildKosong() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
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

  // Widget jika ada antrian
  Widget _buildAntrianCard() {
    return ListView(
      children: [
        _sectionTitle("Nomor Antrian Anda"),
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: _cardDecoration(),
          child: Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.amber,
                child: Text(
                  nomorAntrian.toString(),
                  style: const TextStyle(fontSize: 24, color: Colors.black),
                ),
              ),
              const SizedBox(height: 8),
              Text("Anda berada pada nomor antrian $nomorAntrian"),
            ],
          ),
        ),

        _sectionTitle("Data Pasien"),
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: _cardDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nama : $nama"),
              Text("NIK : $nik"),
              Text("Tanggal Lahir : $tanggalLahir"),
              Text("Jenis Imunisasi : $jenisImunisasi"),
            ],
          ),
        ),

        _sectionTitle("Jadwal Pelayanan"),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: _cardDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Tanggal : $tanggalPelayanan"),
              Text("Lokasi : $lokasi"),
            ],
          ),
        ),
      ],
    );
  }

  // Styling
  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.teal,
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          blurRadius: 6,
          color: Colors.black12,
          offset: Offset(0, 2),
        ),
      ],
      border: Border.all(color: Colors.grey.shade300),
    );
  }
}
