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
import 'package:invest_management/ui/user/user_bloc.dart';
import 'package:invest_management/ui/user/user_state.dart';
import 'package:invest_management/utils/ResourceUtils.dart';

// ignore: must_be_immutable
class UserScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen>{
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
              "Danh sách người dùng",
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
        BlocBuilder<UserBloc, UserState>(
            builder: (context, userState){
              if(userState is GetUsersSuccess && userState.listUser.length > 0) {
                return Expanded(
                    child: ListView.separated(
                        itemCount: userState.listUser.length,
                        separatorBuilder: (context, index) {return Divider(
                          height: 1,
                        );},
                        itemBuilder: (context, index){
                          return ListTile(
                            title: Text(
                              (userState.listUser[index].name?.first ?? "") + " " + (userState.listUser[index].name?.last ?? ""),
                              style: TextStyle(
                                  fontSize: 14
                              ),
                            ),
                            leading: SizedBox(
                              height: 24,
                              width: 24,
                              // child: Image.asset(
                              //   userState.listUser[index].picture.medium,
                              //   color: Colors.black,
                              // ),
                            ),
                            dense: true,
                          );
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