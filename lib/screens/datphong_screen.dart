import 'package:booking_hotel/constant/asset_path_const.dart';
import 'package:booking_hotel/constant/colors_const.dart';
import 'package:booking_hotel/widget/item_hotel.dart';
import 'package:flutter/material.dart';

class DatPhongScreen extends StatefulWidget {
  const DatPhongScreen({super.key});

  @override
  State<DatPhongScreen> createState() => _DatPhongScreenState();
}

class _DatPhongScreenState extends State<DatPhongScreen> {
  int selectedIndex = 0;

  final List<String> categories = ["Tất cả", "Phổ biến", "Xu hướng"];
  List<String> locations = [
    "Hà Nội",
    "Hồ Chí Minh",
    "Đà Nẵng",
    "Vũng Tàu",
    "Nha Trang",
  ];
  List<String> filteredLocations = [];

  @override
  void initState() {
    super.initState();
    filteredLocations = locations;
  }

  String removeAccents(String input) {
    var str = input.toLowerCase();
    str = str.replaceAll(RegExp(r'[àáạảãâầấậẩẫăằắặẳẵ]'), 'a');
    str = str.replaceAll(RegExp(r'[èéẹẻẽêềếệểễ]'), 'e');
    str = str.replaceAll(RegExp(r'[ìíịỉĩ]'), 'i');
    str = str.replaceAll(RegExp(r'[òóọỏõôồốộổỗơờớợởỡ]'), 'o');
    str = str.replaceAll(RegExp(r'[ùúụủũưừứựửữ]'), 'u');
    str = str.replaceAll(RegExp(r'[ỳýỵỷỹ]'), 'y');
    str = str.replaceAll(RegExp(r'[đ]'), 'd');
    return str;
  }

  void filterSearchResults(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredLocations = locations;
      } else {
        String normalizedQuery =
            removeAccents(query.toLowerCase()); // Chuẩn hóa query
        filteredLocations = locations.where((location) {
          String normalizedLocation =
              removeAccents(location.toLowerCase()); // Chuẩn hóa location
          return normalizedLocation.contains(normalizedQuery);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F9FC),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: filterSearchResults,
                        decoration: InputDecoration(
                          hintText: "Tìm kiếm",
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          prefixIcon:
                              Icon(Icons.search, color: Colors.grey.shade400),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.tune, color: Colors.blue),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(categories.length, (index) {
                  bool isSelected = selectedIndex == index;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        decoration: BoxDecoration(
                          color:
                              isSelected ? ColorConst.colorMain : Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border:
                              Border.all(color: ColorConst.colorMain, width: 2),
                        ),
                        child: Text(
                          categories[index],
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : ColorConst.colorMain,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 600,
                child: ListView.separated(
                  itemCount: filteredLocations.length,
                  separatorBuilder: (_, __) =>
                      Divider(color: Colors.grey.shade300),
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ItemHotel(
                          nameHotel: filteredLocations[index],
                          imageHotel: AssetsPathConst.hotel_2,
                          priceHotel: 1000.02303,
                          onPressed: () {},
                        ));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
