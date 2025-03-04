import 'package:booking_hotel/constant/asset_path_const.dart';
import 'package:flutter/material.dart';

class ItemHotel extends StatelessWidget {
  const ItemHotel(
      {super.key, required this.namehotel, required this.imagehotel});
  final String namehotel;
  final String imagehotel;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.asset(imagehotel),
          Text(namehotel),
          Row(
            children: [
              Image.asset(AssetsPathConst.ico_star),
              Text("5.0"),
              Text("(1420 lượt xem) ")
            ],
          )
        ],
      ),
    );
  }
}
