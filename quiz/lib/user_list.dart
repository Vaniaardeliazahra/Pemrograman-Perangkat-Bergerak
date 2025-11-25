import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List users = [];
  bool loading = true;

  Future<void> fetchData() async {
    setState(() => loading = true);

    final url = Uri.parse("https://jsonplaceholder.typicode.com/users");

    final response = await http.get(
      url,
      headers: {
        "Accept": "application/json",
        "User-Agent": "Mozilla/5.0",
      },
    );

    print("Status Code: ${response.statusCode}");

    if (response.statusCode == 200) {
      setState(() {
        users = json.decode(response.body);
        loading = false;
      });
    } else {
      setState(() {
        users = [];
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Pengguna"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchData,
          )
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : users.isEmpty
              ? const Center(child: Text("Tidak ada data"))
              : ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final u = users[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      child: ListTile(
                        title: Text(u["name"]),
                        subtitle:
                            Text("${u["email"]}\n${u["address"]["city"]}"),
                      ),
                    );
                  },
                ),
    );
  }
}
