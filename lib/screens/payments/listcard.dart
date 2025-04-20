import 'package:booking_hotel/constant/asset_path_const.dart';
import 'package:booking_hotel/constant/colors_const.dart';
import 'package:booking_hotel/models/card_model.dart';
import 'package:flutter/material.dart';
class CardManagementScreen extends StatefulWidget {
  final CardInfo? currentCard;

  const CardManagementScreen({super.key, this.currentCard});

  @override
  State<CardManagementScreen> createState() => _CardManagementScreenState();
}

class _CardManagementScreenState extends State<CardManagementScreen> {
  // Danh sách thẻ mẫu (có thể thay bằng dữ liệu từ backend)
  List<CardInfo> cards = [
    CardInfo(cardNumber: "**** **** **** 4679", cardType: "mastercard"),
    CardInfo(cardNumber: "**** **** **** 1234", cardType: "visa"),
  ];

  final TextEditingController _cardNumberController = TextEditingController();
  String _selectedCardType = "mastercard";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản lý thẻ"),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Thẻ hiện có",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Hiển thị danh sách thẻ
            Expanded(
              child: ListView.builder(
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  final card = cards[index];
                  return ListTile(
                    leading: Image.asset(
                      card.cardType == "mastercard"
                          ? AssetsPathConst.mastercard
                          : AssetsPathConst.mastercard,
                      height: 30,
                    ),
                    title: Text(card.cardNumber),
                    trailing: widget.currentCard?.cardNumber == card.cardNumber
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : null,
                    onTap: () {
                      // Chọn thẻ và quay lại màn hình thanh toán
                      Navigator.pop(context, card);
                    },
                  );
                },
              ),
            ),
            const Divider(),
            const Text(
              "Thêm thẻ mới",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Form thêm thẻ mới
            TextField(
              controller: _cardNumberController,
              decoration: const InputDecoration(
                labelText: "Số thẻ",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: _selectedCardType,
              onChanged: (value) {
                setState(() {
                  _selectedCardType = value!;
                });
              },
              items: const [
                DropdownMenuItem(value: "mastercard", child: Text("Mastercard")),
                DropdownMenuItem(value: "visa", child: Text("Visa")),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Thêm thẻ mới vào danh sách
                  final newCardNumber = _cardNumberController.text;
                  if (newCardNumber.isNotEmpty) {
                    final newCard = CardInfo(
                      cardNumber: "**** **** **** ${newCardNumber.substring(newCardNumber.length - 4)}",
                      cardType: _selectedCardType,
                    );
                    setState(() {
                      cards.add(newCard);
                    });
                    // Quay lại màn hình thanh toán với thẻ mới
                    Navigator.pop(context, newCard);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Vui lòng nhập số thẻ")),
                    );
                  }
                },
                child: const Text("Thêm thẻ"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}