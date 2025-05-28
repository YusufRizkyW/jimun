import 'package:flutter/material.dart';

class AntrianDetailScreen extends StatelessWidget {
  final int nomorAntrian;
  final String nama;
  final String nik;
  final String tanggalLahir;
  final String jenisImunisasi;
  final String tanggalPelayanan;
  final String lokasi;

  const AntrianDetailScreen({
    Key? key,
    required this.nomorAntrian,
    required this.nama,
    required this.nik,
    required this.tanggalLahir,
    required this.jenisImunisasi,
    required this.tanggalPelayanan,
    required this.lokasi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Antrian'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    'Nomor Antrian Anda',
                    style: TextStyle(
                        color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.amber,
                    child: Text(
                      nomorAntrian.toString(),
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Anda berada pada nomor antrian $nomorAntrian'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _detailCard('Data Pasien', [
              'Nama: $nama',
              'NIK: $nik',
              'Tanggal lahir: $tanggalLahir',
              'Jenis Imunisasi: $jenisImunisasi',
            ]),
            const SizedBox(height: 16),
            _detailCard('Jadwal pelayanan', [
              'Tanggal: $tanggalPelayanan',
              'Lokasi: $lokasi',
            ]),
          ],
        ),
      ),
    );
  }

  Widget _detailCard(String title, List<String> rows) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
          ),
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rows
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(e),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
