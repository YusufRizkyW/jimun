import 'package:flutter/material.dart';

class EdukasiSlider extends StatelessWidget {
  const EdukasiSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imagePaths = [
  'assets/images/imunisasii.jpg',
  'assets/images/cucitangan.jpg',
  'assets/images/stunting.jpeg',
  'assets/images/kebersihan.jpeg',
  'assets/images/gigi.jpg',
  'assets/images/gizi.jpeg',
];

    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            itemCount: imagePaths.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final path = imagePaths[index];
              return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => Dialog(
                      child: InteractiveViewer(
                        child: Image.asset(path, fit: BoxFit.contain),
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: 3 / 4,
                    child: Image.asset(
                      path,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
          // Tombol kiri
          Align(
            alignment: Alignment.centerLeft,
            child: Icon(Icons.arrow_back_ios, size: 24),
          ),
          // Tombol kanan
          Align(
            alignment: Alignment.centerRight,
            child: Icon(Icons.arrow_forward_ios, size: 24),
          ),
        ],
      ),
    );
  }
}
