import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List pokedex = [];
  dynamic color(index) {
    dynamic setColor;
    switch (pokedex[index]['type'][0]) {
      case 'Grass':
        setColor = Colors.greenAccent;
        break;
      case 'Fire':
        setColor = Colors.redAccent;
        break;
      case 'Water':
        setColor = Colors.blue;
        break;
      case 'Bug':
        setColor = Colors.green;
        break;
      case 'Normal':
        setColor = Colors.purpleAccent;
        break;
      case 'Poison':
        setColor = Colors.lightGreenAccent;
        break;
      case 'Electric':
        setColor = Colors.yellow;
        break;
      case 'Ground':
        setColor = Colors.brown;
        break;
      case 'Psychic':
        setColor = Colors.indigoAccent;
        break;
      case 'Fighting':
        setColor = Colors.lightBlue;
        break;
      case 'Rock':
        setColor = Colors.grey;
        break;
      case 'Ghost':
        setColor = Colors.blueGrey;
        break;
      case 'Ice':
        setColor = Colors.blueAccent;
        break;
      case 'Dragon':
        setColor = Colors.deepOrangeAccent;
        break;
      default:
        Colors.white12;
    }
    return setColor;
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      fetchPokeApp();
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(255, 255, 36, 62),
        Color.fromARGB(255, 0, 0, 0)
      ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child: Stack(
        children: [
          Positioned(
              top: -30,
              right: -30,
              child: Image.asset(
                'assets/pokeball_2.png',
                width: 170,
                fit: BoxFit.fitWidth,
              )),
          Positioned(
            top: 150,
            left: 20,
            child: Text(
              'PokeDex | Tecsup',
              style: TextStyle(
                color: Colors.black12.withOpacity(0.5),
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          Positioned(
            top: 150,
            bottom: 0,
            width: width,
            child: Column(
              children: [
                // ignore: unnecessary_null_comparison
                pokedex != null
                    ? Expanded(
                        child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 3 / 5),
                        itemCount: pokedex.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: InkWell(
                              child: SafeArea(
                                child: Stack(
                                  children: [
                                    Container(
                                      width: width,
                                      margin: const EdgeInsets.only(top: 80),
                                      decoration: const BoxDecoration(
                                          color: Colors.black26,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25))),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                              top: 90,
                                              left: 15,
                                              child: Text(pokedex[index]['num'],
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                  ))),
                                          Positioned(
                                            top: 140,
                                            right: 15,
                                            child: Text(pokedex[index]['name'],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                )),
                                          ),
                                          Positioned(
                                            top: 180,
                                            left: 15,
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  top: 5,
                                                  bottom: 5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(20)),
                                                  color: Colors.black
                                                      .withOpacity(0.5)),
                                              child: Text(
                                                pokedex[index]['type'][0],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: color(index),
                                                    shadows: [
                                                      BoxShadow(
                                                          color: color(index),
                                                          offset: const Offset(
                                                              0, 0),
                                                          spreadRadius: 1.0,
                                                          blurRadius: 20)
                                                    ]),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.topCenter,
                                      child: CachedNetworkImage(
                                        imageUrl: pokedex[index]['img'],
                                        height: 180,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ))
                    : const Center(
                        child: CircularProgressIndicator(),
                      )
              ],
            ),
          )
        ],
      ),
    ));
  }

  void fetchPokeApp() {
    var url = Uri.https('raw.githubusercontent.com',
        '/Biuni/PokemonGO-Pokedex/master/pokedex.json');
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        var data = jsonDecode(value.body);
        pokedex = data['pokemon'];
        setState(() {});
        print(pokedex);
      }
    });
  }
}
