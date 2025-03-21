import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final apiUrl = Uri.https("cataas.com", "cat/gif", {"json": "true"});
  String imageUrl = "";
  bool isQueryProcess = false;

  @override
  void initState() {
    fetchCat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fun Cat",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: fetchCat,
        isExtended: true,
        label: Text("Rafraîchir"),
        icon: const Icon(
          Icons.refresh_outlined,
          size: 32,
        ),
      ),
      body: isQueryProcess ? _SpinnerDelegate() : _ImageDelegate(url: imageUrl),
    );
  }

  Future<void> fetchCat() async {
    setState(() {
      isQueryProcess = true;
    });
    var response = await http.get(apiUrl);
    final responseMapping = jsonDecode(response.body);
    setState(() {
      imageUrl = responseMapping["url"];
      isQueryProcess = false;
    });
  }
}

class _SpinnerDelegate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _ImageDelegate extends StatelessWidget {
  @override
  const _ImageDelegate({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.network(
        url,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
    );
  }
}
