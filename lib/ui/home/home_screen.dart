import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:invest_management/data/model/category.dart';
import 'package:invest_management/data/model/pie_data.dart';
import 'package:invest_management/data/model/triple.dart';
import 'package:invest_management/repositories/asset_repository.dart';
import 'package:invest_management/ui/add_asset/add_asset_bloc.dart';
import 'package:invest_management/ui/add_asset/add_asset_screen.dart';
import 'package:invest_management/ui/add_category/add_category_bloc.dart';
import 'package:invest_management/ui/add_category/add_category_screen.dart';
import 'package:invest_management/ui/category/category_bloc.dart';
import 'package:invest_management/ui/category/category_event.dart';
import 'package:invest_management/ui/category/category_screen.dart';
import 'package:invest_management/ui/home/chose_exporte_file_screen.dart';
import 'package:invest_management/ui/home/drawer.dart';
import 'package:invest_management/ui/home/home_bloc.dart';
import 'package:invest_management/ui/home/home_event.dart';
import 'package:invest_management/ui/home/home_state.dart';
import 'package:invest_management/ui/home/item_asset.dart';
import 'package:invest_management/utils/ResourceUtils.dart';
import 'package:invest_management/utils/enum/add_asset_screen_type.dart';
import 'package:invest_management/utils/enum/add_category_screen_type.dart';
import 'package:invest_management/utils/enum/menu_item_type.dart';
import 'package:invest_management/utils/extension/number_extension.dart';
import 'package:package_info/package_info.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatefulWidget {
  final AssetRepository? repository;
  final PackageInfo packageInfo;
  const HomeScreen({required this.repository, required this.packageInfo});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CustomPopupMenuController categoryController = CustomPopupMenuController();
  CustomPopupMenuController assetController = CustomPopupMenuController();

  List<Category>? listCategory;
  List<PieData>? listPieData;
  Triple<int, int, double>? totalDataTriple;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenuWidget(
        actionClickExport: () {
          BlocProvider.of<HomeBloc>(context).add(ExportAssetEvent());
        },
        actionClickImport: () {
          BlocProvider.of<HomeBloc>(context).add(GetExportedFileEvent());
        },
        packageInfo: widget.packageInfo,
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
          "Danh m???c ?????u t??",
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
                icon:  Image.asset(
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
          child: BlocConsumer <HomeBloc, HomeState>(
              listener: (context, homeState) {
                if(homeState is DeleteAssetSuccess || homeState is DeleteCategorySuccess) {
                  BlocProvider.of<HomeBloc>(context).add(GetDataAssetEvent());
                }
                else if(homeState is ExportAssetSuccess) {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Export th??nh c??ng!", textAlign: TextAlign.center),
                        actions: [
                          TextButton(
                            child: Text("OK"),
                            onPressed:  () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                    },
                  );
                }
                else if(homeState is ExportAssetFailure) {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(homeState.title ?? "", textAlign: TextAlign.center),
                        content: Text(homeState.content ?? "", textAlign: TextAlign.center),
                        actions: [
                          TextButton(
                            child: Text("OK"),
                            onPressed:  () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                    },
                  );
                }
                else if(homeState is GetExportedFileSuccess) {
                  homeState.listPath.forEach((element) {
                    print("_HomeScreenState : build : $element");
                  });
                  Navigator.pop(context);
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
                            heightFactor: 0.5,
                            child: ChooseExportedFileScreen(
                              importCallback: (filePath) {
                                BlocProvider.of<HomeBloc>(context).add(ImportAssetEvent(filePath));
                              },
                              listPath: homeState.listPath,
                            )
                        );
                      }
                  );
                }
                else if(homeState is ImportAssetSuccess) {
                  BlocProvider.of<HomeBloc>(context).add(GetDataAssetEvent());
                }
              },
              buildWhen: (previous, current) {
                if(current is GetDataAssetSuccess) return true;
                return false;
              },
              builder: (context, homeState) {
                if(homeState is GetDataAssetSuccess && homeState.listCategory != null && homeState.listCategory!.length > 0) {
                  return assetList(homeState.listCategory!, homeState.listPieData!, homeState.totalDataTriple!);
                } else {
                  return noData();
                }
              }
          )
      ),
    );
  }

  Widget assetList(List<Category> categories, List<PieData> listPieData, Triple<int, int, double> totalData) {
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
                  width: (MediaQuery.of(context).size.width - 16) * 0.5,
                  padding: const EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.all(2),
                        child: const Text(
                          "T???ng ngu???n v???n",
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
                  width: (MediaQuery.of(context).size.width - 20) * 0.5,
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
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTileTheme(
                  contentPadding: EdgeInsets.only(left: 8, right: 8),
                  dense: true,
                  child: ExpansionTile(
                      title: CustomPopupMenu(
                        controller: categoryController,
                        verticalMargin: 0,
                        showArrow: false,
                        barrierColor: Colors.transparent,
                        pressType: PressType.longPress,
                        menuBuilder: () => _buildMenu((type) {
                          if(type == MenuType.edit) {
                            categoryController.hideMenu();
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
                                        create: (BuildContext context) => AddCategoryBloc(repository: widget.repository),
                                        child: AddCategoryScreen(
                                          repository: widget.repository,
                                          updateCallback: (){
                                            BlocProvider.of<HomeBloc>(context).add(GetDataAssetEvent());
                                          },
                                          type: AddCategoryScreenType.edit,
                                          category: categories[index],
                                        ),
                                      )
                                  );
                                }
                            );
                          } else if(type == MenuType.delete) {
                            categoryController.hideMenu();
                            _showAlertDialogConfirmDelete(
                                context,
                                "X??a l???p t??i s???n",
                                "B???n c?? ch???c ch???n mu???n x??a l???p t??i s???n n??y kh??ng?",
                                ()  {
                                  BlocProvider.of<HomeBloc>(context).add(DeleteCategoryEvent(categories[index]));
                                }
                            );
                          }
                        }),
                        child: SizedBox(
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
                                          color: HexColor(categories[index].color ?? "#000000"),
                                          height: 30,
                                          width: 30,
                                        ),
                                        SizedBox(width: 12),
                                        Text(
                                            categories[index].name!,
                                            style: new TextStyle(
                                                fontSize: 14,
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
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black
                                            )
                                        ),
                                        Text(
                                            "${parseCurrencyProfitPercentPlus(categories[index].totalProfit, categories[index].totalProfitPercent)}",
                                            style: new TextStyle(
                                                fontSize: 14,
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
                                return CustomPopupMenu(
                                  controller: assetController,
                                  verticalMargin: 0,
                                  showArrow: false,
                                  barrierColor: Colors.transparent,
                                  pressType: PressType.longPress,
                                  menuBuilder: () => _buildMenu((type) {
                                    if(type == MenuType.edit) {
                                      assetController.hideMenu();
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
                                                  create: (BuildContext context) => AddAssetBloc(repository: widget.repository),
                                                  child: AddAssetScreen(
                                                    repository: widget.repository,
                                                    updateCallback: (){
                                                      BlocProvider.of<HomeBloc>(context).add(GetDataAssetEvent());
                                                    },
                                                    type: AddAssetScreenType.edit,
                                                    category: categories[index],
                                                    asset: categories[index].assets[index2],
                                                  ),
                                                )
                                            );
                                          }
                                      );
                                    } else if(type == MenuType.delete) {
                                      assetController.hideMenu();
                                      _showAlertDialogConfirmDelete(
                                          context,
                                          "X??a danh m???c ?????u t??",
                                          "B???n c?? ch???c ch???n mu???n x??a danh m???c ?????u t?? n??y kh??ng?",
                                          () {
                                            BlocProvider.of<HomeBloc>(context).add(DeleteAssetEvent(categories[index].assets[index2]));
                                          }
                                       );
                                    }
                                  }),
                                  child: ItemAssetWidget(asset: categories[index].assets[index2]),
                                );
                              }
                          ),
                        ),
                      ]
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget noData() {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Wrap(
          children: [
            Row(
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
                          "T???ng ngu???n v???n",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(2),
                        child: Text(
                          "${parseCurrency(0)}",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 180,
                  width: 180,
                  child: SfCircularChart(
                      series: <DoughnutSeries<PieData, String>>[
                        DoughnutSeries<PieData, String>(
                            innerRadius: "45%",
                            dataSource: [
                              PieData("capital", 1, HexColor("#1C87E6") ,"0%"),
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
            ),
          ]
        )
    );
  }

  Widget _buildMenu(Function(MenuType) action) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Container(
        color: HexColor("#FFF"),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                action.call(MenuType.edit);
              },
              behavior: HitTestBehavior.translucent,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset(
                      IconsResource.ic_edit,
                      color: Colors.black,
                      width: 20,
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 6),
                      child: Text(
                        "C???p nh???t",
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                action.call(MenuType.delete);
              },
              behavior: HitTestBehavior.translucent,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset(
                      IconsResource.ic_delete,
                      color: Colors.black,
                      width: 20,
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 6),
                      child: Text(
                        "Xo??",
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }

  _showAlertDialogConfirmDelete(BuildContext context, String title, String content, Function() actionDelete) {
    Widget cancelButton = TextButton(
      child: Text("H???y"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("X??a"),
      onPressed:  () {
        actionDelete.call();
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}