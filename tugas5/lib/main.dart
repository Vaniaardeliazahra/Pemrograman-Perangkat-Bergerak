import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Berita Karawang',
      home: const BeritaPage(),
    );
  }
}

class BeritaPage extends StatelessWidget {
  const BeritaPage({super.key});

  final List<Map<String, String>> beritaList = const [
    {
      "judul":
          "Pemkab Karawang Berlakukan Pembatasan Jam Operasional Truk Berat di Jalur Badami-Loji",
      "deskripsi":
          "Kepala Dinas Perhubungan (Dishub) Karawang, Muhana saat memasang rambu pembatasan jam operasional truk di jalur Badami–Loji.",
      "gambar": "assets/berita1.jpg"
    },
    {
      "judul": "Bupati Karawang ingatkan ASN berperilaku baik",
      "deskripsi":
          "ASN di lingkungan Pemkab Karawang diingatkan untuk menjaga etika.",
      "gambar": "assets/berita2.jpg"
    },
    {
      "judul":
          "Kacab SH Terate Karawang Hadir, Muskablub IPSI Kabupaten Karawang Berjalan Sukses",
      "deskripsi":
          "Musyawarah Kabupaten Luar Biasa (Muskablub) Ikatan Pencak Silat Indonesia (IPSI) Karawang sukses digelar.",
      "gambar": "assets/berita3.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Berita Karawang Minggu Ini"),
      ),
      body: ListView.builder(
        itemCount: beritaList.length,
        itemBuilder: (context, index) {
          final berita = beritaList[index];

          return GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Mengalihkan ke halaman berita"),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12)),
                    child: Image.asset(
                      berita["gambar"]!,
                      fit: BoxFit.cover,
                      height: 180,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                berita["judul"]!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                berita["deskripsi"]!,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.bookmark_border),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "Berita '${berita["judul"]}' disimpan!"),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
