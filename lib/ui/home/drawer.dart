import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invest_management/utils/ResourceUtils.dart';

class DrawerMenuWidget extends StatelessWidget {
   final Function? actionClickExport;
   final Function? actionClickImport;

   DrawerMenuWidget({
    Key? key,
    this.actionClickExport,
    this.actionClickImport
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        margin: EdgeInsets.only(top: 40),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                print("DrawerMenuWidget : build : onTap export");
                actionClickExport?.call();
              },
              child: ListTile(
                leading: Image.asset(
                  IconsResource.ic_export,
                  height: 24,
                  width: 24,
                ),
                title: Text("Export"),
              ),
            ),
            GestureDetector(
              onTap: () {
                print("DrawerMenuWidget : build : onTap import");
                actionClickImport?.call();
              },
              child: ListTile(
                leading: Image.asset(
                  IconsResource.ic_import,
                  height: 24,
                  width: 24,
                ),
                title: Text("Import"),
              ),
            )
          ],
        ),
      ),
    );
  }
}