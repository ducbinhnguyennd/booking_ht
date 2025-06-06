import 'package:booking_hotel/constant/asset_path_const.dart';
import 'package:booking_hotel/constant/colors_const.dart';
import 'package:booking_hotel/models/user_model.dart';
import 'package:booking_hotel/screens/account/login_screen.dart';
import 'package:booking_hotel/screens/taikhoan/chinhsua_taikhoan.dart';
import 'package:booking_hotel/screens/taikhoan/dieukhoan_screen.dart';
import 'package:booking_hotel/screens/taikhoan/doipass_taikhoan.dart';
import 'package:booking_hotel/apiservice/api_service.dart';
import 'package:booking_hotel/user_Service.dart';
import 'package:booking_hotel/widget/item_ticket.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaikhoanScreen extends StatefulWidget {
  const TaikhoanScreen({super.key});

  @override
  State<TaikhoanScreen> createState() => _TaikhoanScreenState();
}

class _TaikhoanScreenState extends State<TaikhoanScreen> {
  User? currentUser;
  bool isLoading = true;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      if (token.isEmpty) {
        if (mounted) {
          setState(() {
            isLoading = false;
            currentUser = null;
          });
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        }
        return;
      }
      final userProfile = await apiService.getUserProfile(token);
      if (mounted) {
        setState(() {
          currentUser = userProfile;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
        setState(() {
          isLoading = false;
          currentUser = null;
        });
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }
    }
  }

  Future<void> _logout() async {
    try {
      final UserServices us = UserServices();
      await us.deleteinfo();
      if (mounted) {
        setState(() {
          currentUser = null;
        });
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : currentUser == null
              ? const Center(child: Text('Không tìm thấy thông tin người dùng'))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        height: 80,
                        child: const Padding(
                          padding: EdgeInsets.only(top: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Thông tin người dùng',
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
                        height: 80,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        currentUser!.name,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        currentUser!.email,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Vai trò: ${currentUser!.role}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          if (kDebugMode) {
                            print("Nút chỉnh sửa được nhấn");
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChinhSuaTaiKhoan(),
                            ),
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
                            children: const [
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
                        padding: const EdgeInsets.symmetric(vertical: 16),
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
                              builder: (context) => const DoipassTaikhoan(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Image.asset(AssetsPathConst.ico_doipass),
                            ),
                            const Text(
                              'Đổi mật khẩu',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TicketScreen(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Image.asset(AssetsPathConst.ico_the),
                            ),
                            const Text(
                              'Thẻ của tôi',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const TermsAndPolicyScreen(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Image.asset(AssetsPathConst.ico_dieukhoan),
                            ),
                            const Text(
                              'Điều khoản và chính sách',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: _logout,
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Image.asset(AssetsPathConst.ico_dangxuat),
                            ),
                            const Text(
                              'Đăng xuất',
                              style: TextStyle(fontSize: 18),
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
