import 'package:flutter/material.dart';
import '../services/jadwal_service.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  List<Map<String, dynamic>> jadwalList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadJadwal();
  }

  Future<void> loadJadwal() async {
    final data = await JadwalService.fetchJadwal();
    setState(() {
      jadwalList = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Urutkan jadwal berdasarkan tanggal terdekat
    jadwalList.sort((a, b) => DateTime.parse(a['tanggal']).compareTo(DateTime.parse(b['tanggal'])));
    // Ambil 2 event terdekat dari hari ini
    final now = DateTime.now();
    final upcoming = jadwalList.where((j) => DateTime.parse(j['tanggal']).isAfter(now) || DateTime.parse(j['tanggal']).day == now.day).take(2).toList();

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/calendar');
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.teal.shade400,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Kalender Imunisasi',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            if (isLoading)
              const Center(child: CircularProgressIndicator(color: Colors.white))
            else if (upcoming.isEmpty)
              const Text(
                'Belum ada jadwal imunisasi terdekat',
                style: TextStyle(color: Colors.white),
              )
            else
              ...upcoming.map((j) {
                final tgl = DateTime.parse(j['tanggal']);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(
                        '${tgl.day} ${_namaBulan(tgl.month)}: ${j['keterangan']}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                );
              }),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Lihat selengkapnya →',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  static String _namaBulan(int bulan) {
    const nama = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return nama[bulan - 1];
  }
}
