import 'package:booking_hotel/screens/datphong_screen.dart';
import 'package:booking_hotel/screens/trangchu_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static const routeName = 'main_screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const TrangChuScreen(),
    const DatPhongScreen(),
    const TrangChuScreen(),
    const TrangChuScreen(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          BottomAppBar(
            shape: const CircularNotchedRectangle(),
            child: Container(
              height: 50,
              padding: const EdgeInsets.only(top: 5),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFloatingTabIcon(0, Icons.home, "Trang chủ"),
                _buildFloatingTabIcon(1, Icons.calendar_today, "Đặt phòng"),
                _buildFloatingTabIcon(2, Icons.list, "Chuyến đi"),
                _buildFloatingTabIcon(3, Icons.person, "Hồ sơ"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingTabIcon(int index, IconData icon, String label) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onTabSelected(index),
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xff4461F2) : Colors.transparent,
              shape: BoxShape.circle,
              boxShadow: isSelected
                  ? [const BoxShadow(color: Colors.black26, blurRadius: 5)]
                  : [],
            ),
            child: SizedBox(
              width: 50,
              height: 50,
              child: Center(
                child: Icon(
                  icon,
                  size: 30,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          if (isSelected)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(label,
                  style:
                      const TextStyle(color: Color(0xff4461F2), fontSize: 14)),
            ),
        ],
      ),
    );
  }
}
