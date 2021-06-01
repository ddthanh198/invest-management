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
import 'package:invest_management/utils/extension/number_extension.dart';

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

  bool isValidateSuccess = true;

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
    return SingleChildScrollView(
      child: Column(
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
                } else if(
                  assetState is ValidateDataAssetFailure
                ) {
                  isValidateSuccess = false;
                } else if(assetState is ValidateDataAssetSuccess) {
                  if(widget.type == AddAssetScreenType.add) {
                    Asset asset = Asset(
                      null,
                      category.id,
                      _assetNameController.text,
                      int.parse(_capitalController.text),
                      int.parse(_profitController.text),
                      double.parse(_profitPercentController.text),
                    );
                    BlocProvider.of<AddAssetBloc>(context).add(SaveAssetEvent(asset));
                  } else if(widget.type == AddAssetScreenType.edit) {
                    widget.asset?.name = _assetNameController.text;
                    widget.asset?.capital = int.parse(_capitalController.text);
                    widget.asset?.profit = int.parse(_profitController.text);
                    widget.asset?.profitPercent = toPrecision(double.parse(_profitPercentController.text));
                    BlocProvider.of<AddAssetBloc>(context).add(UpdateAssetEvent(widget.asset!));
                  }
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
                          onChanged: (capital) {
                            _profitController.text = "0";
                            _profitPercentController.text = "0.0";
                          },
                          keyboardType: TextInputType.number,
                          controller: _capitalController,
                          decoration: InputDecoration(
                            labelText: 'Vốn (đ)*',
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
                            double profitPercent = 0;

                            if(capital != 0 && profit != "") {
                              profitPercent = int.parse(profit) * 100 / capital;
                            }
                            _profitPercentController.text = toPrecision(profitPercent).toString();
                          },
                          keyboardType: TextInputType.number,
                          controller: _profitController,
                          decoration: InputDecoration(
                            labelText: 'Lợi nhuận (đ)*',
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
                            // double convertedProfitPercent = toPrecision(double.parse(profitPercent));
                            // _profitPercentController.text = convertedProfitPercent.toString();
                            List<String> splitProfitPercent = profitPercent.split('.');
                            double convertedProfitPercent = double.parse(profitPercent);
                            if(splitProfitPercent.length > 1 && splitProfitPercent[1].length > 1) {
                              String convertedProfitPercentString = splitProfitPercent[0] + "." + splitProfitPercent[1].substring(0, 1);
                              _profitPercentController.text = convertedProfitPercentString;
                              _profitPercentController.selection = TextSelection.fromPosition(TextPosition(offset: _profitPercentController.text.length));
                              convertedProfitPercent = double.parse(convertedProfitPercentString);
                            }
                            int capital = (_capitalController.text != "") ? int.parse(_capitalController.text) : 0;
                            int profit = 0;
                            if(capital != 0 && profitPercent != "") {
                              profit = convertedProfitPercent * capital ~/ 100;
                            }
                            _profitController.text = profit.toString();
                          },
                          keyboardType: TextInputType.number,
                          controller: _profitPercentController,
                          decoration: InputDecoration(
                            labelText: 'Lợi nhuận (%)*',
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      if(isValidateSuccess == true) SizedBox()
                      else Container(
                        margin: EdgeInsets.all(8),
                        child: Text(
                          "Không được bỏ trống các trường thông tin.",
                          style: TextStyle(
                            color: Colors.red
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<AddAssetBloc>(context).add(ValidateDataAssetEvent(
                              _assetNameController.text,
                              _capitalController.text,
                              _profitController.text,
                              _profitPercentController.text
                          ));
                        },
                        child: Text("Lưu"),
                      )
                    ],
                  ),
                );
              }
          )
        ],
      ),
    );
  }
}