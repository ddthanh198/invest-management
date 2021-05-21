import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:invest_management/data/model/category.dart';
import 'package:invest_management/repositories/asset_repository.dart';
import 'package:invest_management/ui/category/category_bloc.dart';
import 'package:invest_management/ui/category/category_event.dart';
import 'package:invest_management/ui/category/category_screen.dart';
import 'package:invest_management/ui/home/home_bloc.dart';
import 'package:invest_management/ui/home/home_event.dart';
import 'package:invest_management/ui/home/home_state.dart';
import 'package:invest_management/utils/ResourceUtils.dart';


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
                  return assetList(homeState.listCategory!);
                }
                return Text("no data");
              }
          )
      ),
    );
  }

  Widget assetList(List<Category> categories) {
    return Column(
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
                // SizedBox(
                //   height: 180,
                //   width: 180,
                //   child: SfCircularChart(
                //       series: <DoughnutSeries<PieData, String>>[
                //         DoughnutSeries<PieData, String>(
                //             innerRadius: "50%",
                //             dataSource: [
                //               PieData("hello", 10, Colors.yellow ,"10%"),
                //               PieData("hello", 20, Colors.red,"20%"),
                //               PieData("hello", 30, Colors.blue,"30%"),
                //               PieData("hello", 40, Colors.green,"40%"),
                //             ],
                //             pointColorMapper: (PieData data, _) => data.color,
                //             xValueMapper: (PieData data, _) => data.xData,
                //             yValueMapper: (PieData data, _) => data.yData,
                //             dataLabelMapper: (PieData data, _) => data.text,
                //             dataLabelSettings: DataLabelSettings(isVisible: true)),
                //       ]
                //   ),
                // )
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
                              children: [
                                SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Image.asset(
                                    IconsResource.ic_bank,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: 18),
                                Text(categories[index].name!, style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
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
    );
  }
}