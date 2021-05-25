import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:invest_management/repositories/asset_repository.dart';
import 'package:invest_management/ui/add_asset/add_asset_bloc.dart';
import 'package:invest_management/ui/add_asset/add_asset_screen.dart';
import 'package:invest_management/ui/add_category/add_category_bloc.dart';
import 'package:invest_management/ui/add_category/add_category_screen.dart';
import 'package:invest_management/ui/category/category_bloc.dart';
import 'package:invest_management/ui/category/category_event.dart';
import 'package:invest_management/ui/category/category_state.dart';
import 'package:invest_management/utils/ResourceUtils.dart';

// ignore: must_be_immutable
class CategoryScreen extends StatefulWidget {
  final AssetRepository? repository;
  VoidCallback? updateCallback;
  CategoryScreen({@required this.repository, this.updateCallback});

  @override
  State<StatefulWidget> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>{
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
              "Chọn lớp tài sản",
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
                    widget.updateCallback?.call();
                    Navigator.of(context).pop();
                  }
              ),
            )
          ],
        ),
        Divider(height: 1,),
        BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, categoryState){
              if(categoryState is GetCategorySuccess && categoryState.listCategory != null && categoryState.listCategory!.length > 0) {
                return Expanded(
                    child: ListView.separated(
                        itemCount: categoryState.listCategory!.length,
                        separatorBuilder: (context, index) {return Divider(
                          height: 1,
                        );},
                        itemBuilder: (context, index){
                          if(index < categoryState.listCategory!.length - 1) {
                            return ListTile(
                              title: Text(
                                (categoryState.listCategory![index]).name!,
                                style: TextStyle(
                                    fontSize: 14
                                ),
                              ),
                              leading: SizedBox(
                                height: 24,
                                width: 24,
                                child: Image.asset(
                                  categoryState.listCategory![index].image!,
                                  color: Colors.black,
                                ),
                              ),
                              trailing: Icon(
                                Icons.navigate_next,
                                color: Colors.black,
                              ),
                              dense: true,
                              onTap: (){
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
                                                BlocProvider.of<CategoryBloc>(context).add(GetCategoryEvent());
                                              },
                                              category: categoryState.listCategory![index],
                                            ),
                                          )
                                      );
                                    }
                                );
                              },
                            );
                          } else {
                            return Ink(
                              color: HexColor("#BEEFD2"),
                              child: ListTile(
                                title: Text(
                                  "Thêm lớp tài sản",
                                  style: TextStyle(
                                      fontSize: 14
                                  ),
                                ),
                                leading: SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Image.asset(
                                    IconsResource.ic_add_asset,
                                    color: Colors.black,
                                  ),
                                ),
                                dense: true,
                                onTap: (){
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
                                                  BlocProvider.of<CategoryBloc>(context).add(GetCategoryEvent());
                                                },
                                              ),
                                            )
                                        );
                                      }
                                  );
                                },
                              ),
                            );
                          }
                        }
                    )
                );
              }
              return Text("no data");
            })
      ],
    );
  }
}