import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invest_management/data/model/asset.dart';
import 'package:invest_management/data/model/category.dart';
import 'package:invest_management/repositories/asset_repository.dart';
import 'package:invest_management/ui/add_asset/add_aseet_state.dart';
import 'package:invest_management/ui/add_asset/add_asset_bloc.dart';
import 'package:invest_management/ui/add_asset/add_asset_event.dart';
import 'package:invest_management/utils/enum/add_asset_screen_type.dart';

// ignore: must_be_immutable
class AddAssetScreen extends StatefulWidget {
  final AssetRepository? repository;
  VoidCallback? updateCallback;
  Category category;

  AddAssetScreenType type;
  Asset? asset;

  AddAssetScreen({@required this.repository, this.updateCallback,required this.category, this.type = AddAssetScreenType.add, this.asset});

  @override
  State<StatefulWidget> createState() {
    return _AddAssetScreenState(repository: repository, updateCallback: updateCallback, category: category);
  }
}

class _AddAssetScreenState extends State<AddAssetScreen> {
  final AssetRepository? repository;
  VoidCallback? updateCallback;
  Category category;

  _AddAssetScreenState({@required this.repository, this.updateCallback,required this.category});

  final TextEditingController _assetNameController = TextEditingController();
  final TextEditingController _capitalController = TextEditingController();
  final TextEditingController _profitController = TextEditingController();
  final TextEditingController _profitPercentController = TextEditingController();

  @override
  void initState() {
    if(widget.asset != null) {
      _assetNameController.text = widget.asset!.name!;
      _capitalController.text = widget.asset!.capital.toString();
      _profitController.text = widget.asset!.profit.toString();
      _profitPercentController.text = widget.asset!.profitPercent.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 36,
              height: 36,
            ),
            Text(
              (widget.type == AddAssetScreenType.add) ? "Thêm danh mục đầu tư" : "Cập nhật danh mục đầu tư",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 8),
              width: 36,
              child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }
              ),
            )
          ],
        ),
        Divider(height: 1,),
        BlocBuilder<AddAssetBloc, AddAssetState>(
            builder: (context, assetState) {
              if(assetState is SaveAssetSuccess || assetState is UpdateAssetSuccess) {
                updateCallback?.call();
                Navigator.of(context).pop();
              }
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                      child: Row(
                        children: [
                          Text(
                              category.name!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              )
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      height: 50,
                      child: TextField(
                        controller: _assetNameController,
                        decoration: InputDecoration(
                          labelText: 'Tên danh mục*',
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      height: 50,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _capitalController,
                        decoration: InputDecoration(
                          labelText: 'Vốn (đ)',
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      height: 50,
                      child: TextField(
                        onChanged: (profit) {
                          int capital = (_capitalController.text != "") ? int.parse(_capitalController.text) : 0;
                          int profitPercent = 0;

                          if(capital != 0 && profit != "") {
                            profitPercent = int.parse(profit) * 100 ~/ capital;
                          }
                          _profitPercentController.text = profitPercent.toString();
                        },
                        keyboardType: TextInputType.number,
                        controller: _profitController,
                        decoration: InputDecoration(
                          labelText: 'Lợi nhuận (đ)',
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      height: 50,
                      child: TextField(
                        onChanged: (profitPercent) {
                          int capital = (_capitalController.text != "") ? int.parse(_capitalController.text) : 0;
                          int profit = 0;
                          if(capital != 0 && profitPercent != "") {
                            profit = int.parse(profitPercent) * capital ~/ 100;
                          }
                          _profitController.text = profit.toString();
                        },
                        keyboardType: TextInputType.number,
                        controller: _profitPercentController,
                        decoration: InputDecoration(
                          labelText: 'Lãi suất (%)',
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if( _assetNameController.text == "" ||
                            _capitalController.text == "" ||
                            _profitController.text == "" ||
                            _profitPercentController.text == "") {

                        } else {
                          if(widget.type == AddAssetScreenType.add) {
                            Asset asset = Asset(
                              null,
                              category.id,
                              _assetNameController.text,
                              int.parse(_capitalController.text),
                              int.parse(_profitController.text),
                              int.parse(_profitPercentController.text),
                            );
                            BlocProvider.of<AddAssetBloc>(context).add(SaveAssetEvent(asset));
                          } else if(widget.type == AddAssetScreenType.edit) {
                            widget.asset?.name = _assetNameController.text;
                            widget.asset?.capital = int.parse(_capitalController.text);
                            widget.asset?.profit = int.parse(_profitController.text);
                            widget.asset?.profitPercent = int.parse(_profitPercentController.text);
                            BlocProvider.of<AddAssetBloc>(context).add(UpdateAssetEvent(widget.asset!));
                          }
                        }
                      },
                      child: Text("Lưu"),
                    )
                  ],
                ),
              );
            }
        )
      ],
    );
  }
}