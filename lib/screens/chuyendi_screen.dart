import 'package:flutter/material.dart';
import 'package:booking_hotel/models/trip_model.dart';
import 'package:booking_hotel/widget/item_card_chuyendi_saptoi.dart';
import 'package:booking_hotel/apiservice/api_service.dart';

class ChuyenDiScreen extends StatefulWidget {
  const ChuyenDiScreen({super.key});

  @override
  State<ChuyenDiScreen> createState() => _ChuyenDiScreenState();
}

class _ChuyenDiScreenState extends State<ChuyenDiScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Trip> choXacNhan = [];
  List<Trip> huy = [];
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchTrips();
  }

  Future<void> fetchTrips() async {
    try {
      choXacNhan = await apiService.getTrips('chờ xác nhận');
      huy = await apiService.getTrips('huy');
      setState(() {});
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khi tải chuyến đi: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chuyến đi')),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Chờ xác nhận'),
              Tab(text: 'Đã hủy'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                choXacNhan.isEmpty
                    ? const Center(
                        child: Text('Không có chuyến đi chờ xác nhận'))
                    : ListView.builder(
                        itemCount: choXacNhan.length,
                        itemBuilder: (context, index) => TripCardSapToi(
                          trip: choXacNhan[index],
                          onCancel: fetchTrips,
                        ),
                      ),
                huy.isEmpty
                    ? const Center(child: Text('Không có chuyến đi đã hủy'))
                    : ListView.builder(
                        itemCount: huy.length,
                        itemBuilder: (context, index) => TripCardSapToi(
                          trip: huy[index],
                          isCancelled: true,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
