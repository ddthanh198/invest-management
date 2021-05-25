import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invest_management/data/model/asset.dart';
import 'package:invest_management/data/model/category.dart';
import 'package:invest_management/repositories/asset_repository.dart';
import 'package:invest_management/ui/add_asset/add_aseet_state.dart';
import 'package:invest_management/ui/add_asset/add_asset_bloc.dart';
import 'package:invest_management/ui/add_asset/add_asset_event.dart';

// ignore: must_be_immutable
class AddAssetScreen extends StatelessWidget {
  final AssetRepository? repository;
  VoidCallback? updateCallback;
  Category category;
  AddAssetScreen({@required this.repository, this.updateCallback,required this.category});

  final TextEditingController _assetNameController = TextEditingController();
  final TextEditingController _capitalController = TextEditingController();
  final TextEditingController _profitController = TextEditingController();
  final TextEditingController _profitPercentController = TextEditingController();

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
              "Thêm danh mục đầu tư",
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
              if(assetState is SaveAssetSuccess) {
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
                        controller: _capitalController,
                        decoration: InputDecoration(
                          labelText: 'Vốn*',
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
                        controller: _profitController,
                        decoration: InputDecoration(
                          labelText: 'Lợi nhuận',
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
                        controller: _profitPercentController,
                        decoration: InputDecoration(
                          labelText: 'Lãi suất',
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
                        Asset asset = Asset(
                          null,
                          category.id,
                          _assetNameController.text,
                          int.parse(_capitalController.text),
                          int.parse(_profitController.text),
                          int.parse(_profitPercentController.text),
                        );
                        BlocProvider.of<AddAssetBloc>(context).add(SaveAssetEvent(asset));
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