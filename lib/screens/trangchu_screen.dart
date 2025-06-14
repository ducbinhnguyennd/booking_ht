import 'package:booking_hotel/apiservice/api_service.dart';
import 'package:booking_hotel/constant/asset_path_const.dart';
import 'package:booking_hotel/constant/colors_const.dart';
import 'package:booking_hotel/models/hotel_model.dart';
import 'package:booking_hotel/screens/discover_screen.dart';
import 'package:booking_hotel/widget/item_cardcity.dart';
import 'package:booking_hotel/widget/item_hotel.dart'; // Thêm widget ItemHotel
import 'package:flutter/material.dart';

class TrangChuScreen extends StatefulWidget {
  const TrangChuScreen({super.key});

  @override
  State<TrangChuScreen> createState() => _TrangChuScreenState();
}

class _TrangChuScreenState extends State<TrangChuScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  int selectedIndex = 0;
  final List<String> categories = ["all", "popular", "trending"];
  List<Hotel> hotels = [];
  List<Hotel> filteredHotels = [];
  final ApiService _apiService = ApiService();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchHotels(categories[selectedIndex].toLowerCase());
  }

  void _fetchHotels(String filter) async {
    setState(() {
      isLoading = true;
    });
    try {
      final fetchedHotels = await _apiService.fetchHotels(filter);
      setState(() {
        hotels = fetchedHotels;
        filteredHotels = fetchedHotels;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khi tải dữ liệu: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Container(
            color: Colors.white,
            height: 80,
            child: Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  AssetsPathConst.ico_avatar,
                  height: 40,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DiscoverScreen(
                        namePlace: 'Hồ Chí Minh',
                      ),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Image.asset(
                      AssetsPathConst.maj_saigon_hotel,
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
                        'Majestic SaiGon Hotel',
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: Image.asset(
                        AssetsPathConst.ico_send,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            color: Colors.white,
            child: Row(
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
                      _fetchHotels(categories[index].toLowerCase());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      decoration: BoxDecoration(
                        color: isSelected ? ColorConst.colorMain : Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border:
                            Border.all(color: ColorConst.colorMain, width: 2),
                      ),
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color:
                              isSelected ? Colors.white : ColorConst.colorMain,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  Image.asset(
                    AssetsPathConst.hotel_2,
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
                      'Park Hyatt Saigon',
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
                      'Luxury Room with Balcony',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            color: Colors.white,
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Text(
                  'Các địa điểm',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 150,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                itemCount: filteredHotels.length,
                itemBuilder: (context, index) {
                  final hotel = filteredHotels[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DiscoverScreen(
                            namePlace: hotel.tenKhachSan,
                          ),
                        ),
                      );
                    },
                    child: CategoryCard(
                      title: hotel.tenKhachSan,
                      subtitle: "Khám phá",
                      imagecity: hotel.anhKhachSan[index],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
