import 'package:booking_hotel/apiservice/api_service.dart';
import 'package:booking_hotel/constant/asset_path_const.dart';
import 'package:booking_hotel/constant/colors_const.dart';
import 'package:booking_hotel/screens/payments/payment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 

class Room extends StatefulWidget {
  final String nameHotel;
  final String khachsanId;
  final String imageHotel;
  final String nameRoom;
  final double priceHotel;

  const Room({
    super.key,
    required this.nameHotel,
    required this.nameRoom,
    required this.imageHotel,
    required this.priceHotel,
    required this.khachsanId,
  });

  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  DateTime? ngayNhan; // Ngày nhận phòng
  DateTime? ngayTra; // Ngày trả phòng
  final ApiService apiService = ApiService(); // Khởi tạo API service

  final List<String> imageUrls = [
    AssetsPathConst.room1,
    AssetsPathConst.room1,
    AssetsPathConst.room1,
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Hàm chọn ngày
  Future<void> _selectDate(BuildContext context, bool isNgayNhan) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isNgayNhan) {
          ngayNhan = picked;
          // Đảm bảo ngày trả không nhỏ hơn ngày nhận
          if (ngayTra != null && ngayTra!.isBefore(picked)) {
            ngayTra = picked.add(const Duration(days: 1));
          }
        } else {
          ngayTra = picked;
          // Đảm bảo ngày nhận không lớn hơn ngày trả
          if (ngayNhan != null && ngayNhan!.isAfter(picked)) {
            ngayNhan = picked.subtract(const Duration(days: 1));
          }
        }
      });
    }
  }

  Future<void> _bookRoom() async {
    if (ngayNhan == null || ngayTra == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng chọn ngày nhận và ngày trả phòng')),
      );
      return;
    }

    try {
      final response = await apiService.bookRoom(
        khachSanId: widget.khachsanId,
        tenPhong: widget.nameRoom,
        ngayNhan: DateFormat('yyyy-MM-dd').format(ngayNhan!),
        ngayTra: DateFormat('yyyy-MM-dd').format(ngayTra!),
      );
      print(response);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentScreen(
            nameHotel: widget.nameHotel,
            nameRoom: widget.nameRoom,
            ngayNhan: ngayNhan!,
            ngayTra: ngayTra!,
            priceHotel: widget.priceHotel,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khi đặt phòng: $e')),
      );
    }
  }

  final List<Map<String, String>> amenities = [
    {'icon': AssetsPathConst.bed, 'text': '1 giường đôi lớn'},
    {'icon': AssetsPathConst.people, 'text': '2 người lớn, 1 trẻ em (miễn phí dưới 6 tuổi)'},
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
    {'icon': AssetsPathConst.tv, 'text': 'Truyền hình cáp/vệ tinh'},
  ];

  final List<Map<String, String>> tiennghi = [
    {'icon': AssetsPathConst.bed, 'text': 'Dịch vụ báo thức'},
    {'icon': AssetsPathConst.people, 'text': 'Điều hòa'},
    {'icon': AssetsPathConst.people, 'text': 'Rèm che ánh sáng'},
    {'icon': AssetsPathConst.window, 'text': 'Ổ cắm điện gần giường'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
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
                        child: Image.asset(
                          imageUrls[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 40.0,
                  left: 20,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_new),
                  ),
                ),
                Positioned(
                  bottom: 10.0,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(imageUrls.length, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
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
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${widget.nameHotel} - ${widget.nameRoom}',
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Row(
              children: [
                Image.asset(AssetsPathConst.dooropen),
                const Text(
                  "40m2",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
            // Thêm phần chọn ngày nhận và trả phòng
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text(
                        "Ngày nhận phòng",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => _selectDate(context, true),
                        child: Text(
                          ngayNhan != null
                              ? DateFormat('dd/MM/yyyy').format(ngayNhan!)
                              : 'Chọn ngày',
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        "Ngày trả phòng",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => _selectDate(context, false),
                        child: Text(
                          ngayTra != null
                              ? DateFormat('dd/MM/yyyy').format(ngayTra!)
                              : 'Chọn ngày',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
                  const Text("Điểm đặc trưng", style: TextStyle(fontSize: 20)),
                  Column(
                    children: amenities.map((amenity) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              amenity['icon']!,
                              width: 24.0,
                              height: 24.0,
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              amenity['text']!,
                              style: const TextStyle(fontSize: 16.0),
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
                  const Text("Giải trí", style: TextStyle(fontSize: 20)),
                  Column(
                    children: giaitri.map((amenity) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              amenity['icon']!,
                              width: 24.0,
                              height: 24.0,
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              amenity['text']!,
                              style: const TextStyle(fontSize: 16.0),
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
                  const Text("Tiện nghi", style: TextStyle(fontSize: 20)),
                  Column(
                    children: tiennghi.map((amenity) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              amenity['icon']!,
                              width: 24.0,
                              height: 24.0,
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              amenity['text']!,
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  InkWell(
                    onTap: _bookRoom,
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}