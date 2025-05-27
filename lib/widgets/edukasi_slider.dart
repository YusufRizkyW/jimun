import 'package:flutter/material.dart';

class EdukasiSlider extends StatefulWidget {
  const EdukasiSlider({super.key});

  @override
  State<EdukasiSlider> createState() => _EdukasiSliderState();
}

class _EdukasiSliderState extends State<EdukasiSlider> {
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, String>> edukasiList = [
    {'image': 'assets/images/imunisasii.jpg', 'title': 'Imunisasi Penting'},
    {'image': 'assets/images/cucitangan.jpg', 'title': 'Cuci Tangan Benar'},
    {'image': 'assets/images/stunting.jpeg', 'title': 'Cegah Stunting'},
    {'image': 'assets/images/kebersihan.jpeg', 'title': 'Jaga Kebersihan'},
    {'image': 'assets/images/gigi.jpg', 'title': 'Rawat Gigi Anak'},
    {'image': 'assets/images/gizi.jpeg', 'title': 'Gizi Seimbang'},
  ];
  int _currentIndex = 0;

  // Fungsi scroll ke index tertentu
  void _scrollTo(int index) {
    _scrollController.animateTo(
      index * 190, // Lebar card (170) + padding (20)
      duration: const Duration(milliseconds: 350),
      curve: Curves.ease,
    );
    setState(() => _currentIndex = index);
  }

  // Navigasi kiri
  void _scrollLeft() {
    if (_currentIndex > 0) {
      _scrollTo(_currentIndex - 1);
    } else {
      _scrollTo(edukasiList.length - 1); // Loop ke akhir
    }
  }

  // Navigasi kanan
  void _scrollRight() {
    if (_currentIndex < edukasiList.length - 1) {
      _scrollTo(_currentIndex + 1);
    } else {
      _scrollTo(0); // Loop ke awal
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270, // Ukuran tinggi card digedein
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 38),
            child: ListView.separated(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: edukasiList.length,
              separatorBuilder: (context, index) => const SizedBox(width: 18),
              itemBuilder: (context, index) {
                final item = edukasiList[index];
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Klik gambar buat zoom
                        showDialog(
                          context: context,
                          builder: (_) => Dialog(
                            child: InteractiveViewer(
                              child: Image.asset(item['image']!, fit: BoxFit.contain),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 170, // Lebar gambar lebih besar
                        height: 210, // Tinggi gambar lebih besar
                        color: Colors.white,
                        child: Image.asset(
                          item['image']!,
                          fit: BoxFit.contain, // Gambar selalu utuh
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 150,
                      child: Text(
                        item['title']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          // Tombol kiri
          Positioned(
            left: 0,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: _scrollLeft,
              color: Colors.teal,
              splashRadius: 22,
            ),
          ),
          // Tombol kanan
          Positioned(
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: _scrollRight,
              color: Colors.teal,
              splashRadius: 22,
            ),
          ),
          // Indikator dot
          Positioned(
            bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(edukasiList.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  width: _currentIndex == index ? 16 : 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: _currentIndex == index ? Colors.teal : Colors.teal[100],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
