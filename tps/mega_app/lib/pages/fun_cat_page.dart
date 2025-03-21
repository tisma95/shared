import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mega_app/helper.dart';
import 'package:mega_app/widgets/drawer_menu_widget.dart';
import 'package:http/http.dart' as http;

class FunCatPage extends StatefulWidget {
  @override
  const FunCatPage({super.key});

  @override
  State<FunCatPage> createState() => _FunCatPageState();
}

class _FunCatPageState extends State<FunCatPage> {
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
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: DrawerMenuWidget(pageType: PageType.funcat),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: fetchCat,
        isExtended: true,
        label: Text("Rafraîchir"),
        icon: const Icon(
          Icons.refresh_outlined,
          size: 32,
        ),
      ),
      body: SafeArea(
          child: isQueryProcess
              ? _SpinnerDelegate()
              : _ImageDelegate(
                  url: imageUrl,
                )),
    );
  }

  Future<void> fetchCat() async {
    setState(() {
      isQueryProcess = true;
    });
    var response = await http.get(apiUrl);
    final responseMapping = jsonDecode(response.body);
    setState(() {
      isQueryProcess = false;
      imageUrl = responseMapping["url"];
    });
  }
}

class _SpinnerDelegate extends StatelessWidget {
  @override
  const _SpinnerDelegate();

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
