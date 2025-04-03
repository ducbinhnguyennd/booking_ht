import 'package:flutter/material.dart';

class ItemChonPhong extends StatefulWidget {
  final String nameHotel;
  final String imageHotel;
  final double priceHotel;

  const ItemChonPhong({
    super.key,
    required this.nameHotel,
    required this.imageHotel,
    required this.priceHotel,
  });

  @override
  State<ItemChonPhong> createState() => _ItemChonPhongState();
}

class _ItemChonPhongState extends State<ItemChonPhong> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Image.asset(
                    widget.imageHotel,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 10,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_outlined,
                        color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.nameHotel,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Giá: ${widget.priceHotel.toStringAsFixed(0)} đ',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // Thêm các widget khác để hiển thị thông tin phòng nếu cần
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
