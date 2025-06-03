import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pokemon/home_screen.dart';

class FavoritePokemonPage extends StatefulWidget {
  @override
  State<FavoritePokemonPage> createState() => _FavoritePokemonPageState();
}

class _FavoritePokemonPageState extends State<FavoritePokemonPage> {
  List<String> favoritePokemon = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favoritePokemon = prefs.getStringList('favorite_pokemon') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Pokémon'),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            tooltip: 'Kembali ke Home',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: favoritePokemon.isEmpty
          ? Center(child: Text('Belum ada Pokémon favorit'))
          : ListView.builder(
              itemCount: favoritePokemon.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.favorite, color: Colors.pink),
                  title: Text(favoritePokemon[index]),
                );
              },
            ),
    );
  }
}
