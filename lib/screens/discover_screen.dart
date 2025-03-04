import 'package:booking_hotel/constant/asset_path_const.dart';
import 'package:booking_hotel/widget/item_hotel.dart';
import 'package:flutter/material.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key, required this.namePlace});

  static String routeName = 'discover_screen';
  final String namePlace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(namePlace, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF000000))),
            const Text('Khám phá', style: TextStyle(fontSize: 16, color: Color(0xFF000000)))
            ],
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return ItemHotel(
                nameHotel: 'Khách sạn ${index + 1}',
                imageHotel: AssetsPathConst.hanoi,
                priceHotel: 1000000,
                onPressed: () {},
              );
            }),
      ),
    );
  }
}
