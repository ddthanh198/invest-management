import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:invest_management/data/model/pair.dart';
import 'package:invest_management/utils/ResourceUtils.dart';

// ignore: must_be_immutable
class ChooseExportedFileScreen extends StatefulWidget {
  Function(String)? importCallback;
  List<Pair<String, String>>? listPath;

  ChooseExportedFileScreen({this.importCallback, this.listPath});

  @override
  State<StatefulWidget> createState() => _ChooseExportedFileScreenState();
}

class _ChooseExportedFileScreenState extends State<ChooseExportedFileScreen> {
  int selectedPosition = -1;

  @override
  Widget build(BuildContext context) {

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
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Chọn file",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.pop(context);
                    if(selectedPosition != -1) {
                      widget.importCallback?.call(widget.listPath?[selectedPosition].first ?? "");
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 8),
                    child: Image.asset(
                      IconsResource.ic_tick,
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Divider(height: 1),

        Expanded(
          child: ListView.builder(
              itemCount: widget.listPath?.length ?? 0,
              itemBuilder: (context, index) {
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      selectedPosition = index;
                    });
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: (selectedPosition == index) ? HexColor("#ECEEF5") : Colors.white),
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.listPath![index].second ?? "",
                        ),
                      )
                    )
                  ),
                );
              }),
        )
      ],
    );
  }
}