import 'package:flutter/material.dart';
import '../models/antrian_data.dart';

class AntrianScreen extends StatelessWidget {
  const AntrianScreen({super.key});

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
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'JiMun',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                child: AntrianData.adaAntrian ? _buildAntrianCard() : _buildKosong(),
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

  Widget _buildAntrianCard() {
    return ListView(
      children: [
        _sectionTitle("Nomor Antrian Anda"),
        _infoCard(
          child: Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.amber,
                child: Text(
                  AntrianData.nomorAntrian.toString(),
                  style: const TextStyle(fontSize: 24, color: Colors.black),
                ),
              ),
              const SizedBox(height: 8),
              Text("Anda berada pada nomor antrian ${AntrianData.nomorAntrian}"),
            ],
          ),
        ),
        _sectionTitle("Data Pasien"),
        _infoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nama : ${AntrianData.nama}"),
              Text("NIK : ${AntrianData.nik}"),
              Text("Tanggal Lahir : ${AntrianData.tanggalLahir}"),
              Text("Jenis Imunisasi : ${AntrianData.jenisImunisasi}"),
            ],
          ),
        ),
        _sectionTitle("Jadwal Pelayanan"),
        _infoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Tanggal : ${AntrianData.tanggalPelayanan}"),
              Text("Lokasi : ${AntrianData.lokasi}"),
            ],
          ),
        ),
      ],
    );
  }

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

  Widget _infoCard({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(blurRadius: 6, color: Colors.black12, offset: Offset(0, 2)),
        ],
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: child,
    );
  }
}
