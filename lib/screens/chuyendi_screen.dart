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
  bool isLoadingChoXacNhan = true;
  bool isLoadingHuy = false;
  bool hasLoadedChoXacNhan = false;
  bool hasLoadedHuy = false;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return; // Tránh gọi nhiều lần
      _fetchDataForTab(_tabController.index);
    });
    _fetchDataForTab(0);
  }

  Future<void> _fetchDataForTab(int tabIndex) async {
    if (tabIndex == 0 && !hasLoadedChoXacNhan) {
      try {
        setState(() {
          isLoadingChoXacNhan = true;
        });
        choXacNhan = await apiService.getTrips('chờ xác nhận');
        print('Dữ liệu chờ xác nhận: $choXacNhan');
        hasLoadedChoXacNhan = true;
      } catch (e) {
        print('Lỗi khi tải chuyến đi chờ xác nhận: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Lỗi khi tải chuyến đi: $e')),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            isLoadingChoXacNhan = false;
          });
        }
      }
    } else if (tabIndex == 1 && !hasLoadedHuy) {
      try {
        setState(() {
          isLoadingHuy = true;
        });
        huy = await apiService.getTrips('hủy');
        print('Dữ liệu đã hủy: $huy');
        hasLoadedHuy = true;
      } catch (e) {
        print('Lỗi khi tải chuyến đi đã hủy: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Lỗi khi tải chuyến đi: $e')),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            isLoadingHuy = false;
          });
        }
      }
    }
  }

  Future<void> _reloadAllData() async {
    setState(() {
      hasLoadedChoXacNhan = false; 
      hasLoadedHuy = false; 
      isLoadingChoXacNhan = true; 
      isLoadingHuy = true;
    });

    try {
      final [choXacNhanData, huyData] = await Future.wait([
        apiService.getTrips('chờ xác nhận'),
        apiService.getTrips('hủy'),
      ]);
      setState(() {
        choXacNhan = choXacNhanData;
        huy = huyData;
        hasLoadedChoXacNhan = true;
        hasLoadedHuy = true;
      });
      print('Dữ liệu chờ xác nhận sau reload: $choXacNhan');
      print('Dữ liệu đã hủy sau reload: $huy');
    } catch (e) {
      print('Lỗi khi reload dữ liệu: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi khi tải lại dữ liệu: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoadingChoXacNhan = false;
          isLoadingHuy = false;
        });
      }
    }
  }

  // Hàm làm mới dữ liệu khi kéo xuống
  Future<void> _refreshData(int tabIndex) async {
    if (tabIndex == 0) {
      setState(() {
        hasLoadedChoXacNhan = false;
        isLoadingChoXacNhan = true;
      });
      await _fetchDataForTab(0);
    } else if (tabIndex == 1) {
      setState(() {
        hasLoadedHuy = false;
        isLoadingHuy = true;
      });
      await _fetchDataForTab(1);
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
                isLoadingChoXacNhan
                    ? const Center(child: CircularProgressIndicator())
                    : choXacNhan.isEmpty
                        ? const Center(
                            child: Text('Không có chuyến đi chờ xác nhận'))
                        : RefreshIndicator(
                            onRefresh: () => _refreshData(0),
                            child: ListView.builder(
                              itemCount: choXacNhan.length,
                              itemBuilder: (context, index) => TripCardSapToi(
                                trip: choXacNhan[index],
                                onCancel: _reloadAllData, 
                              ),
                            ),
                          ),
                isLoadingHuy
                    ? const Center(child: CircularProgressIndicator())
                    : huy.isEmpty
                        ? const Center(child: Text('Không có chuyến đi đã hủy'))
                        : RefreshIndicator(
                            onRefresh: () => _refreshData(1),
                            child: ListView.builder(
                              itemCount: huy.length,
                              itemBuilder: (context, index) => TripCardSapToi(
                                trip: huy[index],
                                isCancelled: true,
                              ),
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