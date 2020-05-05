import 'package:flutter/material.dart';
import 'package:doppio_dev_ixn/home/index.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeBloc = HomeBloc();

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doppio.dev'),
      ),
      body: HomeScreen(homeBloc: _homeBloc),
    );
  }
}
