import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

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
          Container(
            padding: const EdgeInsets.all(0),
            width: 36,
            child: IconButton(
              icon: Image.asset(
                'assets/icons/ic_reload.png',
                color: Colors.white,

              ),
              onPressed: () {

              }
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(5, 0, 10, 0),
            padding: const EdgeInsets.all(0),
            width: 36,
            child: IconButton(
              icon: Image.asset(
                'assets/icons/ic_add_asset.png',
                color: Colors.white,
              ),
              onPressed: () {
                print("press add");
              }
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(5),
        color: HexColor("#F2F5FA"),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "Tổng nguồn vốn",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                        ),
                        Text(
                            "1000.000.000 vnd",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black
                          ),
                        ),
                        Text(
                            "-20.000.000 (-50 %)",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red
                          ),
                        ),
                      ],
                    ),
                  ),
                  SfCircularChart(

                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}