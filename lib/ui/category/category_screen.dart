import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:invest_management/repositories/asset_repository.dart';
import 'package:invest_management/ui/add_category/add_category_screen.dart';
import 'package:invest_management/ui/category/category_bloc.dart';
import 'package:invest_management/ui/category/category_event.dart';
import 'package:invest_management/ui/category/category_state.dart';
import 'package:invest_management/utils/ResourceUtils.dart';

class CategoryScreen extends StatefulWidget {
  final AssetRepository? repository;
  const CategoryScreen({@required this.repository});

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
                    Navigator.of(context).pop();
                  }
              ),
            )
          ],
        ),
        Divider(height: 1,),
        BlocProvider(
          create: (context) => CategoryBloc(repository: widget.repository)..add(GetCategoryEvent()),
          child: BlocBuilder<CategoryBloc, CategoryState>(
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
                                  IconsResource.ic_bank,
                                  color: Colors.black,
                                ),
                              ),
                              trailing: Icon(
                                Icons.navigate_next,
                                color: Colors.black,
                              ),
                              dense: true,
                              onTap: (){

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
                                          child: AddCategoryScreen(
                                              repository: widget.repository
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
        )
      ],
    );
  }
}