import 'dart:convert';

import 'package:booking_hotel/constant/asset_path_const.dart';
import 'package:booking_hotel/widget/item_chonphong.dart';
import 'package:flutter/material.dart';

class ItemHotel extends StatelessWidget {
  final String nameHotel;
  final List<String> imagesHotel;
  final double priceHotel;
  final VoidCallback? onPressed;
  final String khachsanId;

  const ItemHotel({
    super.key,
    required this.nameHotel,
    required this.imagesHotel,
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
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.memory(
              base64Decode(imagesHotel[0].split(',')[1]),
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
                  nameHotel,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF111111),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Image.asset(AssetsPathConst.ico_star,
                        width: 16, height: 16),
                    const SizedBox(width: 5),
                    const Text(
                      '5.0',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF141416),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      '(1420 lượt xem)',
                      style: TextStyle(color: Color(0xFF777E90)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Từ ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF111111),
                            ),
                          ),
                          TextSpan(
                            text: '${priceHotel.toStringAsFixed(0)} đ',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF111111),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemChonPhong(
                              nameHotel: nameHotel,
                              imagesHotel: imagesHotel,
                              priceHotel: priceHotel,
                              khachsanId: khachsanId
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
                        'Chọn phòng',
                        style: TextStyle(
                          color: Color(0xFFF4F5F6),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
