import 'package:flutter/material.dart';
import '../services/jadwal_service.dart';

class KalenderDetailScreen extends StatefulWidget {
  const KalenderDetailScreen({super.key});

  @override
  State<KalenderDetailScreen> createState() => _KalenderDetailScreenState();
}

class _KalenderDetailScreenState extends State<KalenderDetailScreen> {
  List<Map<String, dynamic>> jadwalList = [];
  bool isLoading = true;
  int selectedMonth = DateTime.now().month;

  static const List<String> bulan = [
    'JANUARI',
    'FEBRUARI',
    'MARET',
    'APRIL',
    'MEI',
    'JUNI',
    'JULI',
    'AGUSTUS',
    'SEPTEMBER',
    'OKTOBER',
    'NOVEMBER',
    'DESEMBER'
  ];

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
    final eventDays = jadwalList
        .where((j) => DateTime.parse(j['tanggal']).month == selectedMonth)
        .map((j) => DateTime.parse(j['tanggal']).day)
        .toSet();

    final keteranganMap = {
      for (var j in jadwalList.where((j) => DateTime.parse(j['tanggal']).month == selectedMonth))
        DateTime.parse(j['tanggal']).day: j['keterangan']
    };

    int daysInMonth = DateTime(DateTime.now().year, selectedMonth + 1, 0).day;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal.shade400,
        title: const Text('Kalender Imunisasi'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Dropdown bulan
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DropdownButton<int>(
                              value: selectedMonth,
                              items: List.generate(12, (index) {
                                return DropdownMenuItem(
                                  value: index + 1,
                                  child: Text(bulan[index]),
                                );
                              }),
                              onChanged: (val) {
                                setState(() {
                                  selectedMonth = val!;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.teal.shade400,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                bulan[selectedMonth - 1],
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Grid scrollable, fleksibel & anti overflow
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 7,
                                  crossAxisSpacing: 4,
                                  mainAxisSpacing: 4,
                                  childAspectRatio: 1,
                                ),
                                itemCount: daysInMonth,
                                itemBuilder: (context, index) {
                                  final day = index + 1;
                                  final isEventDay = eventDays.contains(day);
                                  return Container(
                                    margin: const EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                      color: isEventDay ? Colors.green : Colors.teal.shade100,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '$day',
                                      style: TextStyle(
                                        color: isEventDay ? Colors.white : Colors.black87,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Keterangan:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 4),
                        ...eventDays.map((day) => Text(
                              'Tanggal $day ${bulan[selectedMonth - 1]}: ${keteranganMap[day]}',
                              style: const TextStyle(fontSize: 14),
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
