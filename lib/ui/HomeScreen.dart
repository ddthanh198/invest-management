import 'package:flutter/cupertino.dart';
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
                shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return new Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ExpansionTile(
                        title: SizedBox(
                            height: 50,
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(categories[index].name, style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold))
                            )
                        ),
                        children: [
                          SizedBox (
                            height: (57 * (categories[index].assets.length)).toDouble() ,
                            child: ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: categories[index].assets.length,
                                separatorBuilder: (BuildContext context, int index) =>
                                    SizedBox(
                                        height: 2,
                                        child: Divider()
                                    ),
                                itemBuilder: (context, index2) {
                                  return Container(
                                      height: 55,
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(categories[index].assets[index2].name),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(categories[index].assets[index2].capital.toString()),
                                                Text(categories[index].assets[index2].profit.toString())
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                  );
                                }
                            ),
                          ),
                        ]
                    ),
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

  var perl = Asset(
    name: "PERL",
    capital: 50000000,
    profit: 800000,
  );

  var wrx = Asset(
    name: "WRX",
    capital: 10000000,
    profit: 90000,
  );

  tienao.assets.add(bitcoin);
  tienao.assets.add(ardr);
  tienao.assets.add(perl);
  tienao.assets.add(wrx);

  var tienGuiNganHang = Category(
      name: "Tiền gửi ngân hàng",
      image: IconsResource.ic_bank,
      color: "#000456"
  );

  var acbBank = Asset(
    name: "ACB",
    capital: 10000000,
    profit: 90000,
  );

  var vtb = Asset(
    name: "VietinBank",
    capital: 10000000,
    profit: 90000,
  );

  var tech = Asset(
    name: "Techcombank",
    capital: 10000000,
    profit: 90000,
  );

  var bidv = Asset(
    name: "BIDV",
    capital: 10000000,
    profit: 90000,
  );

  var shb = Asset(
    name: "SHB",
    capital: 10000000,
    profit: 90000,
  );

  var stb = Asset(
    name: "STB",
    capital: 10000000,
    profit: 90000,
  );

  tienGuiNganHang.assets.add(acbBank);
  tienGuiNganHang.assets.add(vtb);
  tienGuiNganHang.assets.add(tech);
  tienGuiNganHang.assets.add(bidv);
  tienGuiNganHang.assets.add(shb);
  tienGuiNganHang.assets.add(stb);

  result.add(chungKhoan);
  result.add(tienao);
  result.add(tienGuiNganHang);

  return result;
}