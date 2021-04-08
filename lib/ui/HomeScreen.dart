import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:invest_management/model/Asset.dart';
import 'package:invest_management/model/Category.dart';
import 'package:invest_management/model/PieData.dart';
import 'package:invest_management/utils/ResourceUtils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final categories = _fakeData();

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
                IconsResource.ic_reload,
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
                IconsResource.ic_add_asset,
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Row(
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
                    height: 180,
                    width: 180,
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
            ),
            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return new ExpansionTile(
                    title: new Text(categories[index].name, style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),),
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: categories[index].assets.length,
                            itemBuilder: (context, index2) {
                              return Text(categories[index].assets[index2].name);
                            }
                        ),
                      ),
                    ]
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<Category> _fakeData(){
  var result = <Category>[];

  var chungKhoan = Category(
    name: "Chứng khoán",
    image: IconsResource.ic_bank,
    color: "#000456"
  );

  var acb = Asset(
    name: "ACB",
    capital: 1000000000,
    profit: 20000,
  );

  var tcb = Asset(
    name: "TCB",
    capital: 2000000000,
    profit: 5000000,
  );

  chungKhoan.assets.add(acb);
  chungKhoan.assets.add(tcb);


  var tienao = Category(
      name: "Tiền ảo",
      image: IconsResource.ic_bank,
      color: "#000123"
  );

  var bitcoin = Asset(
    name: "Bitcoin",
    capital: 50000000,
    profit: 600000,
  );

  var ardr = Asset(
    name: "ARDR",
    capital: 10000000000,
    profit: 9000000,
  );

  tienao.assets.add(bitcoin);
  tienao.assets.add(ardr);

  result.add(chungKhoan);
  result.add(tienao);

  return result;
}