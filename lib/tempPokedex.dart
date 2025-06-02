import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon/detail_screen.dart';
import 'loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List pokedex = [];

  @override
  void initState() {
    super.initState();
    fetchPokemonData();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

// Logout Button

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              height: 75,
              width: width,
              color: Colors.white,
              child: Stack(
                children: [
                  Positioned(
                    top: -25,
                    right: -25,
                    child: Image.asset(
                      'images/pokeball.png',
                      width: 100,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Text(
                      'Pokédex',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: FutureBuilder<String?>(
                      future: _getUsername(),
                      builder: (context, snapshot) {
                        String username = snapshot.data ?? '';
                        return Text(
                          'Welcome, Trainer ${username.isNotEmpty ? username : "!"}',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontSize: 18,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10, right: 20),
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: _logout,
                  icon: Icon(Icons.logout),
                  label: Text('Log Out'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.redAccent, width: 2),
                    ),
                  ),
                ),
              ),
            ),

            // Pokédex Grid
            Expanded(
              child: pokedex.isNotEmpty
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 1.4),
                      physics: BouncingScrollPhysics(),
                      itemCount: pokedex.length,
                      itemBuilder: (context, index) {
                        var type = pokedex[index]['type'][0];
                        var color = getTypeColor(type);

                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DetailScreen(
                                    key: ValueKey(index),
                                    heroTag: index,
                                    pokemonDetail: pokedex[index],
                                    color: color,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: -10,
                                    right: -10,
                                    child: Image.asset(
                                      'images/pokeball.png',
                                      height: 100,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    right: 5,
                                    child: Hero(
                                      tag: index,
                                      child: CachedNetworkImage(
                                        imageUrl: pokedex[index]['img'],
                                        height: 100,
                                        fit: BoxFit.fitHeight,
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator()),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 55,
                                    left: 15,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        type,
                                        style: TextStyle(
                                          color: Colors.white,
                                          shadows: [
                                            BoxShadow(
                                              color: Colors.blueGrey,
                                              offset: Offset(0, 0),
                                              spreadRadius: 1.0,
                                              blurRadius: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 30,
                                    left: 15,
                                    child: Text(
                                      pokedex[index]['name'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.white,
                                        shadows: [
                                          BoxShadow(
                                            color: Colors.blueGrey,
                                            offset: Offset(0, 0),
                                            spreadRadius: 1.0,
                                            blurRadius: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }

  void fetchPokemonData() async {
    var url = Uri.https('raw.githubusercontent.com',
        '/Biuni/PokemonGO-Pokedex/master/pokedex.json');

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          pokedex = data['pokemon'];
        });
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      print(e);
    }
  }

  Color getTypeColor(String type) {
    switch (type) {
      case "Grass":
        return Colors.greenAccent;
      case "Fire":
        return Colors.redAccent;
      case "Water":
        return Colors.blue;
      case "Poison":
        return Colors.deepPurpleAccent;
      case "Electric":
        return Colors.amber;
      case "Rock":
        return Colors.grey;
      case "Ground":
        return Colors.brown;
      case "Psychic":
        return Colors.indigo;
      case "Fighting":
        return Colors.orange;
      case "Bug":
        return Colors.lightGreenAccent;
      case "Ghost":
        return Colors.deepPurple;
      case "Normal":
        return Colors.black26;
      default:
        return Colors.pink;
    }
  }

  Future<String?> _getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }
}

extension _LogoutExtension on _HomeScreenState {
  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => LoginPage()),
    );
  }
}
