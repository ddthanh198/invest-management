import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Danh mục đầu tư",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/icons/ic_reload.png',
              color: Colors.white,

            ),
            onPressed: () {

            }
          ),
          IconButton(
            icon: Image.asset(
              'assets/icons/ic_add_asset.png',
              color: Colors.white,
            ),
            onPressed: () {

            }
          )
        ],
      ),
      body: Container(
        color: HexColor("#F2F5FA"),
      ),
    );
  }

}