import 'package:booking_hotel/constant/asset_path_const.dart';
import 'package:booking_hotel/constant/colors_const.dart';
import 'package:booking_hotel/screens/payments/payment.dart';
import 'package:flutter/material.dart';

class Room extends StatefulWidget {
  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  final List<String> imageUrls = [
    AssetsPathConst.room1,
    AssetsPathConst.room1,
    AssetsPathConst.room1
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Map<String, String>> amenities = [
    {'icon': AssetsPathConst.bed, 'text': '1 giường đôi lớn'},
    {
      'icon': AssetsPathConst.people,
      'text': '2 người lớn, 1 trẻ em (miễn phí dưới 6 tuổi)'
    },
    {'icon': AssetsPathConst.window, 'text': 'Hướng phòng: Thành phố'},
    {'icon': AssetsPathConst.colban, 'text': 'Ban công/sân hiên'},
    {'icon': AssetsPathConst.nosmoking, 'text': 'Không hút thuốc'},
    {'icon': AssetsPathConst.bath, 'text': 'Bồn tắm/vòi sen riêng'},
    {'icon': AssetsPathConst.toilet, 'text': 'Phòng tắm chung'},
    {'icon': AssetsPathConst.wifi, 'text': 'Wifi miễn phí'},
  ];
  final List<Map<String, String>> giaitri = [
    {'icon': AssetsPathConst.telephone, 'text': 'Điện thoại'},
    {'icon': AssetsPathConst.tienich, 'text': 'Tiện nghi bể bơi'},
    {'icon': AssetsPathConst.tv, 'text': 'Truyền hình cáp/vệ tinh'}
  ];
  final List<Map<String, String>> tiennghi = [
    {'icon': AssetsPathConst.bed, 'text': 'Dịch vụ báo thức'},
    {'icon': AssetsPathConst.people, 'text': 'Điều hòa'},
    {'icon': AssetsPathConst.people, 'text': 'Rèm che ánh sáng'},
    {'icon': AssetsPathConst.window, 'text': 'Ổ cắm điện gần giường'}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              SizedBox(
                height: 250,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: imageUrls.length,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      child: Image.asset(imageUrls[index],
                          fit: BoxFit.cover, width: double.infinity),
                    );
                  },
                ),
              ),
              Positioned(
                  top: 40.0,
                  left: 20,
                  child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios_new))),
              Positioned(
                bottom: 10.0,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(imageUrls.length, (index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      width: 8.0,
                      height: 8.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: _currentPage == index
                            ? const Color.fromARGB(255, 0, 160, 240)
                            : Colors.grey,
                      ),
                    );
                  }),
                ),
              ),
            ]),
            const Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Luxury Deluxe Room - 1 King Bed",
                  style: TextStyle(fontSize: 20)),
            ),
            Row(
              children: [
                Image.asset(AssetsPathConst.dooropen),
                Text(
                  "40m2",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                width: MediaQuery.of(context).size.width / 1.2,
                color: Colors.grey,
                height: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Điểm đặc trưng", style: TextStyle(fontSize: 20)),
                  Column(
                    children: amenities.map((amenity) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              amenity['icon']!,
                              width: 24.0,
                              height: 24.0,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              amenity['text']!,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      width: MediaQuery.of(context).size.width / 1.2,
                      color: Colors.grey,
                      height: 1,
                    ),
                  ),
                  Text("Giải trí", style: TextStyle(fontSize: 20)),
                  Column(
                    children: giaitri.map((amenity) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              amenity['icon']!,
                              width: 24.0,
                              height: 24.0,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              amenity['text']!,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      width: MediaQuery.of(context).size.width / 1.2,
                      color: Colors.grey,
                      height: 1,
                    ),
                  ),
                  Text("Tiện nghi", style: TextStyle(fontSize: 20)),
                  Column(
                    children: tiennghi.map((amenity) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              amenity['icon']!,
                              width: 24.0,
                              height: 24.0,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              amenity['text']!,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PaymentScreen(),
                                ),
                              );
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        width: MediaQuery.of(context).size.width / 1.5,
                        decoration: BoxDecoration(
                          color: ColorConst.colorMain,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: const Text(
                          'Đặt phòng',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
