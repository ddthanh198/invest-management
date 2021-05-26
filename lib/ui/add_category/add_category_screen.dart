import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:invest_management/data/model/category.dart';
import 'package:invest_management/repositories/asset_repository.dart';
import 'package:invest_management/ui/add_category/add_category_bloc.dart';
import 'package:invest_management/ui/add_category/add_category_event.dart';
import 'package:invest_management/ui/add_category/add_category_state.dart';
import 'package:invest_management/ui/choose_image/choose_image_category_screen.dart';
import 'package:invest_management/utils/ResourceUtils.dart';
import 'package:invest_management/utils/enum/add_category_screen_type.dart';

// ignore: must_be_immutable
class AddCategoryScreen extends StatefulWidget {
  final AssetRepository? repository;
  VoidCallback? updateCallback;
  AddCategoryScreenType type;
  Category? category;
  AddCategoryScreen({@required this.repository, this.updateCallback, this.type = AddCategoryScreenType.add, this.category});

  @override
  State<StatefulWidget> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final TextEditingController _categoryNameController = TextEditingController();

  String currentColor = "#000000";
  String currentImage = IconsResource.ic_other;

  @override
  void initState() {
    super.initState();
    if(widget.category != null) {
      currentColor = widget.category!.color!;
      currentImage = widget.category!.image!;
      _categoryNameController.text = widget.category!.name!;
    }
  }

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
              (widget.type == AddCategoryScreenType.add) ? "Thêm lớp tài sản" : "Sửa lớp tài sản",
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
              if(addCategoryState is SaveCategorySuccess || addCategoryState is UpdateCategorySuccess) {
                widget.updateCallback?.call();
                Navigator.of(context).pop();
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
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
                                  child: ChooseImageCategoryScreen(
                                    updateCallback: (image) {
                                      currentImage = image;
                                      BlocProvider.of<AddCategoryBloc>(context).add(RefreshColorOrImage());
                                    },
                                  )
                              );
                            }
                        );
                      },
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "Lựa chọn biểu tượng",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                )
                            ),
                            Image.asset(
                              currentImage,
                              height: 40,
                              width: 40,
                            )
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
                          BlocProvider.of<AddCategoryBloc>(context).add(RefreshColorOrImage())
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
                                child: ClipOval(
                                  child: ColorFiltered(
                                      colorFilter: ColorFilter.mode(HexColor(currentColor), BlendMode.color),
                                      child: Image.asset(IconsResource.ic_pick_color)
                                  ),
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
                        if(widget.type == AddCategoryScreenType.add)  {
                          Category category = Category(
                              null,
                              _categoryNameController.text,
                              currentImage,
                              currentColor
                          );
                          BlocProvider.of<AddCategoryBloc>(context).add(SaveCategoryEvent(category: category));

                        } else if(widget.type == AddCategoryScreenType.edit){
                          widget.category!.name = _categoryNameController.text;
                          widget.category!.image = currentImage;
                          widget.category!.color = currentColor;
                          BlocProvider.of<AddCategoryBloc>(context).add(EditCategoryEvent(category: widget.category));
                        }
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
}