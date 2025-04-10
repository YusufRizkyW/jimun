import 'package:flutter/material.dart';

class EdukasiSlider extends StatelessWidget {
  const EdukasiSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140, // Tinggi maksimal untuk slider
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          edukasiCard('assets/images/stunting.jpeg'),
          const SizedBox(width: 12),
          edukasiCard('assets/images/gizi.jpeg'),
          const SizedBox(width: 12),
          edukasiCard('assets/images/kebersihan.jpeg'),
          const SizedBox(width: 12),
          edukasiCard('assets/images/stuntingg.jpeg'),
          const SizedBox(width: 12),
          edukasiCard('assets/images/gizii.jpeg'),
          const SizedBox(width: 12),
          edukasiCard('assets/images/kebersihann.jpeg'),
        ],
      ),
    );
  }

//   Widget edukasiCard(String imgPath) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(12),
//       child: AspectRatio(
//         aspectRatio: 16 / 9, // Menjaga rasio agar konsisten
//         child: Image.asset(
//           imgPath,
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }
// }

  Widget edukasiCard(String imgPath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        imgPath,
        fit: BoxFit.contain,
      ),
    );
  }
  
}