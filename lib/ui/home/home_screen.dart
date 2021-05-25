import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:invest_management/data/model/category.dart';
import 'package:invest_management/data/model/pie_data.dart';
import 'package:invest_management/data/model/triple.dart';
import 'package:invest_management/repositories/asset_repository.dart';
import 'package:invest_management/ui/category/category_bloc.dart';
import 'package:invest_management/ui/category/category_event.dart';
import 'package:invest_management/ui/category/category_screen.dart';
import 'package:invest_management/ui/home/home_bloc.dart';
import 'package:invest_management/ui/home/home_event.dart';
import 'package:invest_management/ui/home/home_state.dart';
import 'package:invest_management/utils/ResourceUtils.dart';
import 'package:invest_management/utils/extension/number_extension.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatefulWidget {
  final AssetRepository? repository;
  const HomeScreen({@required this.repository});

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
                  IconsResource.ic_reload,
                  color: Colors.black,
                ),
                onPressed: () {
                  BlocProvider.of<HomeBloc>(context).add(GetDataAssetEvent());
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
                  showModalBottomSheet<void>(
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                          borderRadius:BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12)
                          )
                      ),
                      backgroundColor: Colors.white,
                      context: context,
                      builder: (BuildContext buildContext) {
                        return FractionallySizedBox(
                            heightFactor: 0.85,
                            child: BlocProvider(
                              create: (BuildContext context) => CategoryBloc(repository: widget.repository)..add(GetCategoryEvent()),
                              child: CategoryScreen(
                                repository: widget.repository,
                                updateCallback: () {
                                  BlocProvider.of<HomeBloc>(context).add(GetDataAssetEvent());
                                },
                              ),
                            )
                        );
                      }
                  );
                }
            ),
          )
        ],
      ),
      body: Container(
          padding: const EdgeInsets.all(5),
          color: HexColor("#F2F5FA"),
          child: BlocBuilder <HomeBloc, HomeState>(
              builder: (context, homeState) {
                if(homeState is GetDataAssetSuccess && homeState.listCategory != null && homeState.listCategory!.length > 0) {
                  return assetList(homeState.listCategory!, homeState.listPieData!, homeState.totalDataTriple!);
                }
                return Text("no data");
              }
          )
      ),
    );
  }

  Widget assetList(List<Category> categories, List<PieData> listPieData, Triple<int, int, int> totalData) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          "${parseCurrency(totalData.first)}",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(2),
                        child: Text(
                          "${parseCurrencyProfitPercentPlus(totalData.second, totalData.third!)}",
                          style: TextStyle(
                              fontSize: 16,
                              color: totalData.second! >= 0 ? Colors.green : Colors.red
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
                            dataSource: listPieData,
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      ((categories[index].image != null) ? categories[index].image : IconsResource.ic_other)!,
                                      color: HexColor(((categories[index].color != null) ? categories[index].color : "#000000")!,),
                                      height: 30,
                                      width: 30,
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                        categories[index].name!,
                                        style: new TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black
                                        )
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                        "${parseCurrency(categories[index].totalCapital)}",
                                        style: new TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black
                                        )
                                    ),
                                    Text(
                                        "${parseCurrencyProfitPercentPlus(categories[index].totalProfit, categories[index].totalProfitPercent)}",
                                        style: new TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            color: categories[index].totalProfit >= 0 ? Colors.green : Colors.red
                                        )
                                    ),
                                  ],
                                )
                              ],
                            )
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
                                        Text(categories[index].assets[index2].name!),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              parseCurrency(categories[index].assets[index2].capital),
                                            ),
                                            Text(
                                              parseCurrencyProfitPercentPlus(categories[index].assets[index2].profit, categories[index].assets[index2].profitPercent!),
                                              style: TextStyle(
                                                  color: categories[index].assets[index2].profit! > 0 ? Colors.green : Colors.red
                                              ),
                                            ),
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
    );
  }
}