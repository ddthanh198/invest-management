import 'package:flutter/material.dart';
import 'package:invest_management/data/db/asset_dao.dart';
import 'package:invest_management/data/db/database.dart';
import 'package:invest_management/data/model/asset.dart';
import 'package:invest_management/data/model/category.dart';
import 'package:invest_management/utils/ResourceUtils.dart';

class AssetRepository {
  final AssetDao? assetDao;

  const AssetRepository({@required this.assetDao});

  Future<List<Category>?> getDataAsset() async {
    List<Category> categories = await assetDao!.findAllCategories();
    return assetDao!.findAllCategories();

  }

  Future<List<Asset>> getAssetsWithCategoryId(int categoryId) async {
    return assetDao!.findAllAssetWithCategoryId(categoryId);
  }

  Future<List<Category>?> getCategory() async {
    return assetDao!.findAllCategories();
  }

  Future<void> saveCategory(Category category) async {
    return assetDao!.insertCategory(category);
  }

  Future<void> saveAsset(Asset asset) async {
    return assetDao!.insertAsset(asset);
  }

  // List<Category> _fakeData(){
  //   var result = <Category>[];
  //
  //   var chungKhoan = Category(
  //       name: "Chứng khoán",
  //       image: IconsResource.ic_bank,
  //       color: "#000456"
  //   );
  //
  //   var acb = Asset(
  //     name: "ACB",
  //     capital: 1000000000,
  //     profit: 20000,
  //   );
  //
  //   var tcb = Asset(
  //     name: "TCB",
  //     capital: 2000000000,
  //     profit: 5000000,
  //   );
  //
  //   chungKhoan.assets.add(acb);
  //   chungKhoan.assets.add(tcb);
  //
  //
  //   var tienao = Category(
  //       name: "Tiền ảo",
  //       image: IconsResource.ic_bank,
  //       color: "#000123"
  //   );
  //
  //   var bitcoin = Asset(
  //     name: "Bitcoin",
  //     capital: 50000000,
  //     profit: 600000,
  //   );
  //
  //   var ardr = Asset(
  //     name: "ARDR",
  //     capital: 10000000000,
  //     profit: 9000000,
  //   );
  //
  //   var perl = Asset(
  //     name: "PERL",
  //     capital: 50000000,
  //     profit: 800000,
  //   );
  //
  //   var wrx = Asset(
  //     name: "WRX",
  //     capital: 10000000,
  //     profit: 90000,
  //   );
  //
  //   tienao.assets.add(bitcoin);
  //   tienao.assets.add(ardr);
  //   tienao.assets.add(perl);
  //   tienao.assets.add(wrx);
  //
  //   var tienGuiNganHang = Category(
  //       name: "Tiền gửi ngân hàng",
  //       image: IconsResource.ic_bank,
  //       color: "#000456"
  //   );
  //
  //   var acbBank = Asset(
  //     name: "ACB",
  //     capital: 10000000,
  //     profit: 90000,
  //   );
  //
  //   var vtb = Asset(
  //     name: "VietinBank",
  //     capital: 10000000,
  //     profit: 90000,
  //   );
  //
  //   var tech = Asset(
  //     name: "Techcombank",
  //     capital: 10000000,
  //     profit: 90000,
  //   );
  //
  //   var bidv = Asset(
  //     name: "BIDV",
  //     capital: 10000000,
  //     profit: 90000,
  //   );
  //
  //   var shb = Asset(
  //     name: "SHB",
  //     capital: 10000000,
  //     profit: 90000,
  //   );
  //
  //   var stb = Asset(
  //     name: "STB",
  //     capital: 10000000,
  //     profit: 90000,
  //   );
  //
  //   tienGuiNganHang.assets.add(acbBank);
  //   tienGuiNganHang.assets.add(vtb);
  //   tienGuiNganHang.assets.add(tech);
  //   tienGuiNganHang.assets.add(bidv);
  //   tienGuiNganHang.assets.add(shb);
  //   tienGuiNganHang.assets.add(stb);
  //
  //   result.add(chungKhoan);
  //   result.add(tienao);
  //   result.add(tienGuiNganHang);
  //
  //   return result;
  // }

}