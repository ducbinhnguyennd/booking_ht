import 'package:booking_hotel/constant/asset_path_const.dart';
import 'package:booking_hotel/constant/colors_const.dart';
import 'package:booking_hotel/screens/account/login_screen.dart';
import 'package:booking_hotel/screens/taikhoan/chinhsua_taikhoan.dart';
import 'package:booking_hotel/screens/taikhoan/dieukhoan_screen.dart';
import 'package:booking_hotel/screens/taikhoan/doipass_taikhoan.dart';
import 'package:booking_hotel/widget/item_ticket.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TaikhoanScreen extends StatefulWidget {
  const TaikhoanScreen({super.key});

  @override
  State<TaikhoanScreen> createState() => _TaikhoanScreenState();
}

class _TaikhoanScreenState extends State<TaikhoanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: Column(children: [
          Container(
            color: Colors.white,
            height: 80,
            child: const Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Thông tin người dùng ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Image.asset(
            AssetsPathConst.ico_avatar2,
            height: 150,
          ),
          const SizedBox(height: 20),
          Text('Rimuru Tempest', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              if (kDebugMode) {
                print("Nút chỉnh sửa được nhấn");
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ChinhSuaTaiKhoan()),
              );
            },
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                color: ColorConst.colorMain,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit, color: Colors.white),
                  Text(
                    'Chỉnh sửa',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: Colors.grey,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DoipassTaikhoan()),
              );
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Image.asset(AssetsPathConst.ico_doipass),
                ),
                Text(
                  'Đổi mật khẩu',
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TicketScreen()),
              );
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Image.asset(AssetsPathConst.ico_the),
                ),
                Text(
                  'Thẻ của tôi ',
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TermsAndPolicyScreen()),
              );
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Image.asset(AssetsPathConst.ico_dieukhoan),
                ),
                Text(
                  'Điều khoản  và chính sách',
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Image.asset(AssetsPathConst.ico_dangxuat),
                ),
                Text(
                  'Đăng xuất',
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          )
        ]));
  }
}
