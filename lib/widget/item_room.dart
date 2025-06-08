import 'package:booking_hotel/constant/asset_path_const.dart';
import 'package:booking_hotel/screens/khachsan/Room.dart';
import 'package:booking_hotel/widget/item_chonphong.dart';
import 'package:flutter/material.dart';

class ItemRoom extends StatelessWidget {
  final String nameHotel;
  final String nameRoom;
  final String khachsanId;
  final String imageHotel;
  final double priceHotel;
  final VoidCallback? onPressed;

  const ItemRoom({
    super.key,
    required this.nameHotel,
    required this.nameRoom,
    required this.imageHotel,
    required this.priceHotel,
    required this.khachsanId,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                imageHotel,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nameRoom,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF111111),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${priceHotel.toStringAsFixed(0)} đ',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF111111),
                              )),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Room(
                                    nameHotel: nameHotel,
                                    priceHotel: priceHotel,
                                    imageHotel: imageHotel,
                                    khachsanId: khachsanId,
                                    nameRoom: nameRoom


                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                              backgroundColor: const Color(0xFF4461F2),
                            ),
                            child: const Text(
                              'Chọn',
                              style: TextStyle(
                                color: Color(0xFFF4F5F6),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        ],
                      ),
                      Text("Chưa bao gồm thuế và các loại phí")
                    ]))
          ],
        ));
  }
}
