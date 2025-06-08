import 'package:booking_hotel/constant/asset_path_const.dart';
import 'package:booking_hotel/constant/colors_const.dart';
import 'package:booking_hotel/models/card_model.dart';
import 'package:booking_hotel/screens/payments/listcard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentScreen extends StatefulWidget {
  final String nameHotel;
  final String nameRoom;
  final DateTime ngayNhan;
  final DateTime ngayTra;
  final double priceHotel;

  const PaymentScreen({
    super.key,
    required this.nameHotel,
    required this.nameRoom,
    required this.ngayNhan,
    required this.ngayTra,
    required this.priceHotel,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  CardInfo? selectedCard = CardInfo(
    cardNumber: "**** **** **** 4679",
    cardType: "mastercard",
    cardDateEnd: '',
    Cvv: '',
  );

  // Tính số đêm
  int getSoDem() {
    return widget.ngayTra.difference(widget.ngayNhan).inDays;
  }

  // Tính tổng tiền
  double tinhTongTien() {
    final soDem = getSoDem();
    final giaCoBan = widget.priceHotel * soDem;
    final thueVaPhi = giaCoBan * 0.1; // Thuế và phí 10%
    return giaCoBan + thueVaPhi;
  }

  @override
  Widget build(BuildContext context) {
    final soDem = getSoDem();
    final giaCoBan = widget.priceHotel * soDem;
    final thueVaPhi = giaCoBan * 0.1;
    final tongTien = giaCoBan + thueVaPhi;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Thanh toán',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF000000),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  Image.asset(
                    AssetsPathConst.room1,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.2),
                          Colors.transparent,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Text(
                      widget.nameHotel,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 4,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: ColorConst.colorMain,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            AssetsPathConst.ico_star,
                            height: 16,
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            '5.0',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Text(
                      widget.nameRoom,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(10),
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[200],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Ngày nhận phòng",
                        style: TextStyle(fontSize: 17, color: Color(0xff515151)),
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy').format(widget.ngayNhan),
                        style: const TextStyle(fontSize: 17, color: Color(0xff000000)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Ngày trả phòng",
                        style: TextStyle(fontSize: 17, color: Color(0xff515151)),
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy').format(widget.ngayTra),
                        style: const TextStyle(fontSize: 17, color: Color(0xff000000)),
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Số khách",
                        style: TextStyle(fontSize: 17, color: Color(0xff515151)),
                      ),
                      Text(
                        "2",
                        style: TextStyle(fontSize: 17, color: Color(0xff000000)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(10),
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[200],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$soDem đêm",
                        style: const TextStyle(fontSize: 17, color: Color(0xff515151)),
                      ),
                      Text(
                        "${giaCoBan.toStringAsFixed(0)} ₫",
                        style: const TextStyle(fontSize: 17, color: Color(0xff000000)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Thuế và Phí (10%)",
                        style: TextStyle(fontSize: 17, color: Color(0xff515151)),
                      ),
                      Text(
                        "${thueVaPhi.toStringAsFixed(0)} ₫",
                        style: const TextStyle(fontSize: 17, color: Color(0xff000000)),
                      ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Tổng cộng",
                        style: TextStyle(fontSize: 17, color: Color(0xff515151)),
                      ),
                      Text(
                        "${tongTien.toStringAsFixed(0)} ₫",
                        style: const TextStyle(fontSize: 17, color: Color(0xff000000)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[200],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    selectedCard?.cardType == "mastercard"
                        ? AssetsPathConst.mastercard
                        : AssetsPathConst.Visa,
                    height: 30,
                  ),
                  Text(selectedCard?.cardNumber ?? "Chưa chọn thẻ"),
                  GestureDetector(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CardManagementScreen(
                            currentCard: selectedCard,
                          ),
                        ),
                      );
                      if (result != null && result is CardInfo) {
                        setState(() {
                          selectedCard = result;
                        });
                      }
                    },
                    child: const Text(
                      "Thay đổi",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                // Thêm logic thanh toán nếu cần (ví dụ: gửi API thanh toán)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Thanh toán thành công!')),
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
                    'Thanh toán',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}