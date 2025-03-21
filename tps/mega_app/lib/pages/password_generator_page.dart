import 'package:flutter/material.dart';
import 'package:mega_app/helper.dart';
import 'package:mega_app/widgets/drawer_menu_widget.dart';

class PasswordGeneratorPage extends StatefulWidget {
  @override
  const PasswordGeneratorPage({super.key});

  @override
  State<PasswordGeneratorPage> createState() => _PasswordGeneratorPageState();
}

class _PasswordGeneratorPageState extends State<PasswordGeneratorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fun Cat"),
      ),
      drawer: DrawerMenuWidget(
        pageType: PageType.password,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Text('Hello World Fun Cat Page!'),
        ),
      )),
    );
  }
}
