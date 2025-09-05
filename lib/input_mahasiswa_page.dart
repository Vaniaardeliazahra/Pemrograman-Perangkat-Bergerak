import 'package:flutter/material.dart';

class InputMahasiswaPage extends StatefulWidget {
  const InputMahasiswaPage({super.key});

  @override
  State<InputMahasiswaPage> createState() => _InputMahasiswaPageState();
}

class _InputMahasiswaPageState extends State<InputMahasiswaPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _umurController = TextEditingController();
  final _alamatController = TextEditingController();
  final _kontakController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Input Mahasiswa")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: "Nama"),
                validator: (value) => value == null || value.isEmpty
                    ? "Tidak boleh kosong"
                    : null,
              ),
              TextFormField(
                controller: _umurController,
                decoration: const InputDecoration(labelText: "Umur"),
                validator: (value) => value == null || value.isEmpty
                    ? "Tidak boleh kosong"
                    : null,
              ),
              TextFormField(
                controller: _alamatController,
                decoration: const InputDecoration(labelText: "Alamat"),
                validator: (value) => value == null || value.isEmpty
                    ? "Tidak boleh kosong"
                    : null,
              ),
              TextFormField(
                controller: _kontakController,
                decoration: const InputDecoration(labelText: "Kontak"),
                validator: (value) => value == null || value.isEmpty
                    ? "Tidak boleh kosong"
                    : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final mahasiswa = {
                      "nama": _namaController.text,
                      "umur": _umurController.text,
                      "alamat": _alamatController.text,
                      "kontak": _kontakController.text,
                    };
                    
                    Navigator.pop(context, mahasiswa);
                  }
                },
                child: const Text("Simpan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
