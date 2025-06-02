import 'package:flutter/material.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informasi Aplikasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Pokedex',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Aplikasi ini merupakan Pokedex sederhana yang menampilkan daftar Pokémon beserta informasi detailnya. '
              'Pengguna dapat mencari dan melihat detail setiap Pokémon yang tersedia di aplikasi ini.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Fitur Utama:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('- Melihat daftar Pokémon'),
            Text('- Melihat detail setiap Pokémon'),
            Text('- Pencarian Pokémon'),
            SizedBox(height: 16),
            Text(
              'Aplikasi ini dibuat untuk memenuhi tugas praktikum Mobile Programming.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}