import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:invest_management/utils/ResourceUtils.dart';

// ignore: must_be_immutable
class ChooseImageCategoryScreen extends StatelessWidget {
  Function(String) updateCallback;

  ChooseImageCategoryScreen({required this.updateCallback});

  @override
  Widget build(BuildContext context) {
    List<String> images = _getListSampleImage();

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 6),
          height: 4,
          width: 30,
          color: HexColor("#DEDEDE"),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Text(
            "Chọn ảnh",
            style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        Divider(height: 1,),

        Expanded(
          child: Container(
            margin: EdgeInsets.all(10),
            child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 24,
                  childAspectRatio: 3,
                ),

                itemCount: images.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                      onTap: () {
                        updateCallback(images[index]);
                        Navigator.of(context).pop();
                      },
                      child: Image.asset(
                        images[index],
                        height: 20,
                        width: 20,
                      )
                  );
                }
            ),
          ),
        )
      ],
    );
  }

  List<String> _getListSampleImage() {
    List<String> listImages = List.empty(growable: true);

    listImages.add(IconsResource.ic_bank);
    listImages.add(IconsResource.ic_cryptocurrency);
    listImages.add(IconsResource.ic_forex);
    listImages.add(IconsResource.ic_real_estate);
    listImages.add(IconsResource.ic_stock);
    listImages.add(IconsResource.ic_other);

    return listImages;
  }
}