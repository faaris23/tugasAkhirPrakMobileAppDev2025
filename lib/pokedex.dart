import 'dart:core';

class Pokedex {
  final List<Pokemon> pokemon;

  Pokedex({required this.pokemon});

  factory Pokedex.fromJson(Map<String, dynamic> json) {
    return Pokedex(
      pokemon: (json['pokemon'] as List<dynamic>?)
              ?.map((v) => Pokemon.fromJson(v))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pokemon'] = pokemon.map((v) => v.toJson()).toList();
    return data;
  }
}

class Pokemon {
  final int id;
  final String number;
  final String name;
  final String img;
  final List<String> type;
  final String height;
  final String weight;
  final String candy;
  final int candyCount;
  final String egg;
  final double spawnChance;
  final double avgSpawns;
  final String spawnTime;
  final List<double> multipliers;
  final List<String> weaknesses;
  final List<NextEvolution> nextEvolution;

  Pokemon({
    required this.id,
    required this.number, // Updated parameter name
    required this.name,
    required this.img,
    required this.type,
    required this.height,
    required this.weight,
    required this.candy,
    required this.candyCount,
    required this.egg,
    required this.spawnChance,
    required this.avgSpawns,
    required this.spawnTime,
    required this.multipliers,
    required this.weaknesses,
    required this.nextEvolution,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'] as int,
      number: json['num'] as String, // Updated to match the new field name
      name: json['name'] as String,
      img: json['img'] as String,
      type: (json['type'] as List<dynamic>).cast<String>(),
      height: json['height'] as String,
      weight: json['weight'] as String,
      candy: json['candy'] as String,
      candyCount: json['candy_count'] is int
          ? json['candy_count'] as int
          : (json['candy_count'] ?? 0),
      egg: json['egg'] as String,
      spawnChance: (json['spawn_chance'] as num).toDouble(),
      avgSpawns: (json['avg_spawns'] as num).toDouble(),
      spawnTime: json['spawn_time'] as String,
      multipliers: json['multipliers'] == null
          ? []
          : (json['multipliers'] as List<dynamic>)
              .map((e) => (e as num).toDouble())
              .toList(),
      weaknesses: (json['weaknesses'] as List<dynamic>).cast<String>(),
      nextEvolution: json['next_evolution'] == null
          ? []
          : (json['next_evolution'] as List<dynamic>)
              .map((v) => NextEvolution.fromJson(v))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['num'] = number; // Updated to match the new field name
    data['name'] = name;
    data['img'] = img;
    data['type'] = type;
    data['height'] = height;
    data['weight'] = weight;
    data['candy'] = candy;
    data['candy_count'] = candyCount;
    data['egg'] = egg;
    data['spawn_chance'] = spawnChance;
    data['avg_spawns'] = avgSpawns;
    data['spawn_time'] = spawnTime;
    data['multipliers'] = multipliers;
    data['weaknesses'] = weaknesses;
    data['next_evolution'] = nextEvolution.map((v) => v.toJson()).toList();
    return data;
  }
}

class NextEvolution {
  final String num;
  final String name;

  NextEvolution({required this.num, required this.name});

  factory NextEvolution.fromJson(Map<String, dynamic> json) {
    return NextEvolution(
      num: json['num'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['num'] = num;
    data['name'] = name;
    return data;
  }
}
