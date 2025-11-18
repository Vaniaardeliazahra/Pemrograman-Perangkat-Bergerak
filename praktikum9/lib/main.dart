import 'package:flutter/material.dart';
import 'kucing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Kucing kucing1 = Kucing('Kuma', 5, 'Abu-Abu');
  String pesan = 'Berat awal kucing: 5 kg';

  void makan() {
    setState(() {
      pesan = kucing1.makan(1000); // tambah 1 kg
    });
  }

  void lari() {
    setState(() {
      pesan = kucing1.lari(0.5); // kurangi 0,5 kg
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Latihan 2')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                pesan + '\nBerat sekarang: ${kucing1.berat.toStringAsFixed(2)} kg',
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: makan,
                    child: const Text('Makan (+1 kg)'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: lari,
                    child: const Text('Lari (-0.5 kg)'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
