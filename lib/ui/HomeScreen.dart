import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:invest_management/model/PieData.dart';
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
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Danh mục đầu tư",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.all(0),
            width: 36,
            child: IconButton(
              icon: Image.asset(
                'assets/icons/ic_reload.png',
                color: Colors.black,

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
                color: Colors.black,
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
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
                        Container(
                          margin: EdgeInsets.all(2),
                          child: const Text(
                              "Tổng nguồn vốn",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(2),
                          child: Text(
                              "1000.000.000 vnd",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(2),
                          child: Text(
                              "-20.000.000 (-50 %)",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: SfCircularChart(
                        series: <DoughnutSeries<PieData, String>>[
                          DoughnutSeries<PieData, String>(
                              innerRadius: "50%",
                              dataSource: [
                                PieData("hello", 10, Colors.yellow ,"10%"),
                                PieData("hello", 20, Colors.red,"20%"),
                                PieData("hello", 30, Colors.blue,"30%"),
                                PieData("hello", 40, Colors.green,"40%"),
                              ],
                              pointColorMapper: (PieData data, _) => data.color,
                              xValueMapper: (PieData data, _) => data.xData,
                              yValueMapper: (PieData data, _) => data.yData,
                              dataLabelMapper: (PieData data, _) => data.text,
                              dataLabelSettings: DataLabelSettings(isVisible: true)),
                        ]
                    ),
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