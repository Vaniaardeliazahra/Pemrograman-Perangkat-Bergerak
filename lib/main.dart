import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'input_mahasiswa_page.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas Praktikum 2',
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Map<String, dynamic>? mahasiswa;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Main Page")),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfilePage(),
                      ),
                    );
                  },
                  child: const Text("Profile Page"),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InputMahasiswaPage(),
                      ),
                    );
                    if (result != null) {
                      setState(() {
                        mahasiswa = result;
                      });
                    }
                  },
                  child: const Text("Input Data Mahasiswa"),
                ),
              ],
            ),

            const SizedBox(height: 20),
            if (mahasiswa != null) ...[
              Text("Nama: ${mahasiswa!['nama']}"),
              Text("Umur: ${mahasiswa!['umur']}"),
              Text("Alamat: ${mahasiswa!['alamat']}"),
              Text("Kontak: ${mahasiswa!['kontak']}"),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  final tel = mahasiswa!['kontak'];
                  final Uri url = Uri(scheme: 'tel', path: tel);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tidak bisa membuka aplikasi telepon'),
                      ),
                    );
                  }
                },
                child: const Text("Call"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
