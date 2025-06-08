import 'dart:convert';

import 'package:booking_hotel/constant/asset_path_const.dart';
import 'package:booking_hotel/screens/bottombooking/PriceAndBookButton.dart';
import 'package:booking_hotel/screens/khachsan/listRoom.dart';
import 'package:booking_hotel/widget/item_cardcity.dart';
import 'package:booking_hotel/widget/item_danhgia.dart';
import 'package:flutter/material.dart';

class ItemChonPhong extends StatefulWidget {
  final String nameHotel;
  final String khachsanId;
  final List<String> imagesHotel;
  final double priceHotel;

  const ItemChonPhong({
    super.key,
    required this.nameHotel,
    required this.imagesHotel,
    required this.priceHotel,
    required this.khachsanId
  });

  @override
  State<ItemChonPhong> createState() => _ItemChonPhongState();
}

final List<Map<String, String>> amenities = [
  {'name': 'Thích hợp cho\ncác hoạt động', 'image': 'chitiet_1.png'},
  {'name': 'Bể bơi\ntuyệt vời', 'image': 'chitiet_2.png'},
  {'name': 'Quanh cảnh\nthành phố', 'image': 'chitiet_3.png'},
  {'name': 'Sạch sẽ,\nvệ sinh', 'image': 'chitiet_4.png'},
  {'name': 'Dịch vụ chất\nlượng cao', 'image': 'chitiet_5.png'},
  {'name': 'Bàn tiếp tân\n24H', 'image': 'chitiet_6.png'},
  {'name': 'Đưa đón\nsân bay', 'image': 'chitiet_7.png'},
  {'name': 'Sân golf', 'image': 'chitiet_8.png'},
];

final List<Map<String, dynamic>> listdanhgia = [
  {
    "image": AssetsPathConst.chitiet1,
    "name": "Nguyễn Văn A",
    "content":
        "Thỏa mãi, đúng là thỏi mãi. Trong đời ta lần đầu thấy khách điếm sang trong như thế này.",
    "rating": 4.5,
  },
  {
    "image": AssetsPathConst.chitiet2,
    "name": "Trần Thị B",
    "content": "Khách sạn rất đẹp, dịch vụ tốt, tôi sẽ quay lại lần sau.",
    "rating": 4.8,
  },
  {
    "image": AssetsPathConst.chitiet3,
    "name": "Lê Văn C",
    "content": "Phòng sạch sẽ, nhân viên thân thiện, nhưng giá hơi cao.",
    "rating": 4.2,
  },
  {
    "image": AssetsPathConst.chitiet3,
    "name": "Lê Văn D",
    "content": "Phòng sạch sẽ, nhân viên thân thiện, nhưng giá hơi cao.",
    "rating": 4.0,
  },
];

class _ItemChonPhongState extends State<ItemChonPhong> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Image.memory(
                    base64Decode(widget.imagesHotel[0].split(',')[1]),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 36,
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
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
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
                      Row(
                        children: [
                          Image.asset(AssetsPathConst.ico_location),
                          Text(
                            'Giá: ${widget.priceHotel.toStringAsFixed(0)} đ',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.grey,
                          height: 1,
                        ),
                      ),
                      const Text(
                        "Ảnh chụp",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                          height: 150,
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 12,
                              childAspectRatio: 1,
                            ),
                            itemCount: widget.imagesHotel.length,
                            itemBuilder: (context, index) {
                              return CategoryCard(
                                title: "",
                                subtitle: "",
                                imagecity: widget.imagesHotel[index],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "Điểm nổi bật",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  GridView.count(
                    padding: const EdgeInsets.all(0),
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: amenities.map((amenity) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/${amenity['image']}',
                            width: 40,
                            height: 40,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            amenity['name']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  const Text(
                    "Mô tả",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const Text(
                    "Đỗ xe và Wi-Fi luôn miễn phí, vì vậy quý khách có thể giữ liên lạc, đến và đi tùy ý. Nằm ở vị trí trung tâm tại Quận 3 của Hồ Chí Minh, chỗ nghỉ này đặt quý khách ở gần các điểm thu hút và tùy chọn ăn uống thú vị.",
                  ),
                  const Text(
                    "Đánh giá",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Row(
                    children: [
                      Image.asset(AssetsPathConst.ico_star),
                      const Text(
                        "5.0",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      const Text(" (3,102 đánh giá)"),
                    ],
                  ),
                  GridView.builder(
                    padding: const EdgeInsets.all(0),
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 12,
                      childAspectRatio: 3,
                    ),
                    itemCount: listdanhgia.length,
                    itemBuilder: (context, index) {
                      final review = listdanhgia[index];
                      return Item_DanhGia(
                        avatar: review['image']!,
                        name: review['name']!,
                        content: review['content']!,
                        rating: review['rating'] as double,
                      );
                    },
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: PriceAndBookButton(
        price: widget.priceHotel,
        onBookNow: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Listroom(
                namehotel: widget.nameHotel,
                khachsanId: widget.khachsanId,
              ),
            ),
          );
        },
      ),
    );
  }
}
