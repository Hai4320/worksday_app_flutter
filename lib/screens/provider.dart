import 'package:flutter/material.dart';
import 'package:worksday_app/widgets/stateful/navbar.dart';

class Provider extends StatefulWidget {
  const Provider({ Key? key }) : super(key: key);

  @override
  _ProviderState createState() => _ProviderState();
}

class _ProviderState extends State<Provider> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Center(
        child: Text("Hello world"),
      ),
      bottomNavigationBar: NavBar(),

    );
  }
}