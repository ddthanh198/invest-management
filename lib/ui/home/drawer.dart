import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invest_management/utils/ResourceUtils.dart';
import 'package:package_info/package_info.dart';

// ignore: must_be_immutable
class DrawerMenuWidget extends StatelessWidget {
   final Function? actionClickExport;
   final Function? actionClickImport;
   final PackageInfo? packageInfo;

   DrawerMenuWidget({
    Key? key,
    this.actionClickExport,
    this.actionClickImport,
    this.packageInfo
  }) : super(key: key);
   
  @override
  Widget build(BuildContext context) {
    print("DrawerMenuWidget : build : ");
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
              behavior: HitTestBehavior.translucent,
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
            ),
            if(packageInfo != null) Column(
              children: [
                Divider(height: 2),
                Container(
                  margin: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(packageInfo?.appName ?? ""),
                      Text(packageInfo?.version ?? "")
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}