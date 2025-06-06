import 'package:booking_hotel/constant/asset_path_const.dart';
import 'package:booking_hotel/constant/colors_const.dart';
import 'package:booking_hotel/models/card_model.dart';
import 'package:booking_hotel/screens/payments/listcard.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  CardInfo? selectedCard = CardInfo(
      cardNumber: "**** **** **** 4679",
      cardType: "mastercard",
      cardDateEnd: '',
      Cvv: '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Thanh toán',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000000)))
            ],
          )),
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
                          Colors.transparent
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
                      'La Vela SaiGon Hotel',
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
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
                  const Positioned(
                      bottom: 16,
                      left: 16,
                      child: Text(
                        'Luxury Deluxe Room - 1 King Bed',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.all(10),
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200]),
              child: const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Ngày nhận phòng",
                        style:
                            TextStyle(fontSize: 17, color: Color(0xff515151)),
                      ),
                      Text(
                        "03/08/2023",
                        style:
                            TextStyle(fontSize: 17, color: Color(0xff000000)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Ngày trả phòng",
                        style:
                            TextStyle(fontSize: 17, color: Color(0xff515151)),
                      ),
                      Text(
                        "05/08/2023",
                        style:
                            TextStyle(fontSize: 17, color: Color(0xff000000)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Số khách",
                        style:
                            TextStyle(fontSize: 17, color: Color(0xff515151)),
                      ),
                      Text(
                        "2",
                        style:
                            TextStyle(fontSize: 17, color: Color(0xff000000)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.all(10),
              height: 130,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200]),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "2 đêm",
                        style:
                            TextStyle(fontSize: 17, color: Color(0xff515151)),
                      ),
                      Text(
                        "5,619,948 ₫",
                        style:
                            TextStyle(fontSize: 17, color: Color(0xff000000)),
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Thuế và Phí (10%)",
                        style:
                            TextStyle(fontSize: 17, color: Color(0xff515151)),
                      ),
                      Text(
                        "561, 994 ₫ ",
                        style:
                            TextStyle(fontSize: 17, color: Color(0xff000000)),
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tổng cộng",
                        style:
                            TextStyle(fontSize: 17, color: Color(0xff515151)),
                      ),
                      Text(
                        "6,181,942 ₫",
                        style:
                            TextStyle(fontSize: 17, color: Color(0xff000000)),
                      ),
                    ],
                  )
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
                      // Cập nhật thẻ được chọn nếu có kết quả trả về
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
                    'Thanh toán',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
