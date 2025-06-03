import 'package:flutter/material.dart';
import 'package:pokemon/home_screen.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informasi Aplikasi'),
      ),
      body: Stack(
        children: [
          // Background Charizard
          Positioned.fill(
            child: Opacity(
              opacity: 0.15,
              child: Image.network(
                'https://assets.pokemon.com/assets/cms2/img/pokedex/full/006.png',
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          // Konten utama
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pokedex',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Aplikasi ini merupakan Pokedex sederhana yang menampilkan daftar Pokémon beserta informasi detailnya. '
                  'Pengguna dapat mencari dan melihat detail setiap Pokémon yang tersedia di aplikasi ini.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Fitur Utama:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text('- Melihat daftar Pokémon'),
                const Text('- Melihat detail setiap Pokémon'),
                const SizedBox(height: 16),
                const Text(
                  'Aplikasi ini dibuat untuk memenuhi tugas praktikum Mobile Programming.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Dibuat oleh: ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Text('Faaris Sayyid Al-Ghozali'),
                const Text('NIM : 12322059'),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Center(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.home),
                      label: const Text('Kembali ke Home'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 18),
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (route) => false,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
