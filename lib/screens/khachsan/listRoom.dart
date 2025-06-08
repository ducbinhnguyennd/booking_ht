import 'package:booking_hotel/constant/asset_path_const.dart';
import 'package:booking_hotel/widget/item_room.dart';
import 'package:flutter/material.dart';

class Listroom extends StatefulWidget {
  const Listroom({super.key, required this.namehotel, required this.khachsanId});
  final String namehotel;
  final String khachsanId;
  @override
  State<Listroom> createState() => _ListroomState();
}

final List<Map<String, dynamic>> listroom = [
  {"image": AssetsPathConst.giuongdon, "room": "Phòng đơn", "price": 500000},
  {"image": AssetsPathConst.giuongdoi, "room": "Phòng đôi", "price": 800000},
  {"image": AssetsPathConst.vip, "room": "Phòng vip", "price": 1000000},
];

class _ListroomState extends State<Listroom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Danh sách phòng',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000000)))
            ],
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child:
                  Text(widget.namehotel, style: const TextStyle(fontSize: 22)),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0, left: 8.0),
              child: Text('Có 3 loại phòng',
                  style: TextStyle(fontSize: 20, color: Color(0xFF000000))),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: listroom.map((room) {
                    return ItemRoom(
                      nameHotel: widget.namehotel,
                      khachsanId: widget.khachsanId,
                      nameRoom: room['room'],
                      imageHotel: room['image'],
                      priceHotel: (room['price'] as num).toDouble(),
                      onPressed: () {},
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
