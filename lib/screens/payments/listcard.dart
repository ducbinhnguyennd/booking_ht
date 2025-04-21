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
    CardInfo(
        cardNumber: "**** **** **** 4679",
        cardType: "mastercard",
        cardDateEnd: '04/29',
        Cvv: '255'),
    CardInfo(
        cardNumber: "**** **** **** 1234",
        cardType: "visa",
        cardDateEnd: '05/27',
        Cvv: '624'),
  ];

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardDateController = TextEditingController();
  final TextEditingController _cardCvvController = TextEditingController();
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
            Expanded(
              child: ListView.builder(
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  final card = cards[index];
                  return Dismissible(
                    key: Key(card.cardNumber), // Key duy nhất cho mỗi thẻ
                    direction: DismissDirection
                        .endToStart, // Chỉ cho phép vuốt từ phải sang trái
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20.0),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    onDismissed: (direction) {
                      setState(() {
                        cards.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text("Đã xóa thẻ ${card.cardNumber}")),
                      );
                    },
                    child: ListTile(
                      leading: Image.asset(
                        card.cardType == "mastercard"
                            ? AssetsPathConst.mastercard
                            : AssetsPathConst.Visa,
                        height: 30,
                      ),
                      title: Text(card.cardNumber),
                      trailing: widget.currentCard?.cardNumber ==
                              card.cardNumber
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : null,
                      onTap: () {
                        Navigator.pop(context, card);
                      },
                    ),
                    confirmDismiss: (direction) async {
                      return await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Xác nhận"),
                          content: const Text("Bạn có chắc muốn xóa thẻ này?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text("Hủy"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text("Xóa"),
                            ),
                          ],
                        ),
                      );
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
            TextField(
              controller: _cardNumberController,
              decoration: const InputDecoration(
                labelText: "Số thẻ",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _cardDateController,
              decoration: const InputDecoration(
                labelText: "Ngày hết hạn",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _cardCvvController,
              decoration: const InputDecoration(
                labelText: "CVV",
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
                DropdownMenuItem(
                    value: "mastercard", child: Text("Mastercard")),
                DropdownMenuItem(value: "visa", child: Text("Visa")),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Thêm thẻ mới vào danh sách
                  final newCardNumber = _cardNumberController.text;
                  final newCardDate = _cardDateController.text;
                  final newCardCvv = _cardCvvController.text;
                  if (newCardNumber.isNotEmpty ||
                      newCardDate.isNotEmpty ||
                      newCardCvv.isNotEmpty) {
                    final newCard = CardInfo(
                      cardNumber:
                          "**** **** **** ${newCardNumber.substring(newCardNumber.length - 4)}",
                      cardType: _selectedCardType,
                      cardDateEnd:
                          '${newCardDate.substring(0, 2)}/${newCardDate.substring(2, 4)}',
                      Cvv: '${newCardCvv.substring(0, 3)}',
                    );
                    setState(() {
                      cards.add(newCard);
                    });
                    // Navigator.pop(context, newCard);
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
