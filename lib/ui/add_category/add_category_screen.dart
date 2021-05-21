import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:invest_management/data/model/category.dart';
import 'package:invest_management/repositories/asset_repository.dart';
import 'package:invest_management/ui/add_category/add_category_bloc.dart';
import 'package:invest_management/ui/add_category/add_category_event.dart';
import 'package:invest_management/ui/add_category/add_category_state.dart';
import 'package:invest_management/ui/category/category_bloc.dart';
import 'package:invest_management/ui/category/category_event.dart';
import 'package:invest_management/ui/home/home_bloc.dart';
import 'package:invest_management/ui/home/home_event.dart';
import 'package:invest_management/utils/ResourceUtils.dart';

// ignore: must_be_immutable
class AddCategoryScreen extends StatefulWidget {
  final AssetRepository? repository;
  VoidCallback? updateCallback;
  AddCategoryScreen({@required this.repository, this.updateCallback});

  @override
  State<StatefulWidget> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final TextEditingController _categoryNameController = TextEditingController();

  String currentColor = "";

  @override
  void dispose() {
    super.dispose();
    _categoryNameController.dispose();
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
              "Thêm lớp tài sản",
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
        BlocBuilder<AddCategoryBloc, AddCategoryState>(
            builder: (context, addCategoryState){
              if(addCategoryState is SaveCategorySuccess) {
                widget.updateCallback?.call();
                Navigator.of(context).pop();
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        print("chọn biểu tượng");
                      },
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            Text(
                                "Lựa chọn biểu tượng",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                titlePadding: const EdgeInsets.all(0.0),
                                contentPadding: const EdgeInsets.all(0.0),
                                content: SingleChildScrollView(
                                  child: ColorPicker(
                                    pickerColor: Colors.red,
                                    onColorChanged: (Color color) {
                                      print("color = ${color.value.toRadixString(16)}");
                                      currentColor = color.value.toRadixString(16);
                                    },
                                    colorPickerWidth: 300.0,
                                    pickerAreaHeightPercent: 0.7,
                                    enableAlpha: true,
                                    displayThumbColor: true,
                                    showLabel: true,
                                    paletteType: PaletteType.hsv,
                                    pickerAreaBorderRadius: const BorderRadius.only(
                                      topLeft: const Radius.circular(2.0),
                                      topRight: const Radius.circular(2.0),
                                    ),
                                  ),
                                ),
                              );
                            }
                        ).then((value) => {
                          BlocProvider.of<AddCategoryBloc>(context).add(PickColorEvent(currentColor))
                        }
                        );
                      },
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "Lựa chọn màu sắc",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                )
                            ),
                            SizedBox(
                                height: 30,
                                width: 30,
                                child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(HexColor(getColor(addCategoryState)), BlendMode.modulate),
                                    child: Image.asset(IconsResource.ic_pick_color)
                                )
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      height: 50,
                      child: TextField(
                        controller: _categoryNameController,
                        decoration: InputDecoration(
                          labelText: 'Lớp tài sản',
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
                        Category category = Category(
                            null,
                            _categoryNameController.text,
                            getColor(addCategoryState),
                            ""
                        );
                        BlocProvider.of<AddCategoryBloc>(context).add(SaveCategoryEvent(category: category));
                      },
                      child: Text("Lưu"),
                    )
                  ],
                ),
              );
            })
      ],
    );
  }



  String getColor(AddCategoryState categoryState) {
    if(categoryState is PickColorSuccess) return "#${categoryState.color}";
    else return "#ffffff";
  }
}