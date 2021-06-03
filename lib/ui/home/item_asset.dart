import 'package:flutter/material.dart';
import 'package:invest_management/data/model/asset.dart';
import 'package:invest_management/utils/extension/number_extension.dart';

class ItemAssetWidget extends StatelessWidget {
  final Asset asset;

  const ItemAssetWidget({
    Key? key,
    required this.asset
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 55,
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                asset.name!,
                style: TextStyle(
                    fontSize: 14
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    parseCurrency(asset.capital),
                  ),
                  Text(
                    parseCurrencyProfitPercentPlus(asset.profit, asset.profitPercent!),
                    style: TextStyle(
                        fontSize: 14,
                        color: asset.profit! > 0 ? Colors.green : Colors.red
                    ),
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}