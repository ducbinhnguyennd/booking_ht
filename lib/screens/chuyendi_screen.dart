import 'package:booking_hotel/constant/asset_path_const.dart';
import 'package:booking_hotel/models/trip_model.dart';
import 'package:flutter/material.dart';

class ChuyenDi_Screen extends StatefulWidget {
  const ChuyenDi_Screen({super.key});

  @override
  State<ChuyenDi_Screen> createState() => _ChuyenDi_ScreenState();
}

class _ChuyenDi_ScreenState extends State<ChuyenDi_Screen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Danh sách giả lập các chuyến đi (chỉ có dữ liệu cho tab "Sắp tới")
  List<Trip> trips = [
    Trip(
      hotelName: "Fusion Original Saigon",
      roomType: "Luxury Deluxe Room - 1 King Bed",
      status: "upcoming",
      isConfirmed: false, // Thuộc "Muốn đến"
    ),
    Trip(
      hotelName: "New Hotel",
      roomType: "Standard Room",
      status: "upcoming",
      isConfirmed: true, // Thuộc "Chỗ xác nhận"
    ),
  ];

  // Biến để theo dõi trạng thái lọc: true = "Chỗ xác nhận", false = "Muốn đến"
  bool _showConfirmedTrips = false;

  // Biến để theo dõi tab hiện tại
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Lắng nghe sự thay đổi của tab
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Widget hiển thị khi không có chuyến đi
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 80,
            color: Colors.blue,
          ),
          const SizedBox(height: 16),
          const Text(
            "Chưa có chuyến đi nào",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Điều hướng đến màn hình đặt phòng
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text(
              "Đặt phòng ngay!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget hiển thị khi tab chưa có dữ liệu
  Widget _buildNoDataState() {
    return const Center(
      child: Text(
        "Chưa có dữ liệu",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Widget hiển thị danh sách chuyến đi cho tab "Sắp tới"
  Widget _buildUpcomingTripList() {
    // Lọc danh sách chuyến đi: chỉ lấy các chuyến đi "upcoming" và phù hợp với trạng thái xác nhận
    final filteredTrips = trips
        .where((trip) =>
            trip.status == "upcoming" &&
            trip.isConfirmed == _showConfirmedTrips)
        .toList();

    if (filteredTrips.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredTrips.length,
      itemBuilder: (context, index) {
        final trip = filteredTrips[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[300],
                      child: const Center(child: Text("Hình ảnh")),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            trip.hotelName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            trip.roomType,
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            width: MediaQuery.of(context).size.width,
                            height: 35,
                            decoration: BoxDecoration(
                              color: trip.isConfirmed
                                  ? Colors.orange[100]
                                  : Colors.blue[100],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                    trip.isConfirmed
                                        ? AssetsPathConst.ico_clock
                                        : AssetsPathConst.ico_tele,
                                    width: 20),
                                const SizedBox(width: 8),
                                Text(
                                  trip.isConfirmed
                                      ? "Chỗ xác nhận"
                                      : "Muốn đến",
                                  style: TextStyle(
                                      color: trip.isConfirmed
                                          ? Colors.orange[800]
                                          : Colors.blue,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget chứa hai nút "Muốn đến" và "Chỗ xác nhận"
  Widget _buildFilterButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  _showConfirmedTrips = false; // Hiển thị "Muốn đến"
                });
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: _showConfirmedTrips ? Colors.grey : Colors.blue,
                ),
                backgroundColor:
                    _showConfirmedTrips ? Colors.white : Colors.blue[50],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                'Muốn đến',
                style: TextStyle(
                  color: _showConfirmedTrips ? Colors.grey : Colors.blue,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  _showConfirmedTrips = true; // Hiển thị "Chỗ xác nhận"
                });
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: _showConfirmedTrips ? Colors.blue : Colors.grey,
                ),
                backgroundColor:
                    _showConfirmedTrips ? Colors.blue[50] : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                'Chỗ xác nhận',
                style: TextStyle(
                  color: _showConfirmedTrips ? Colors.blue : Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Column(
          children: [
            // Header
            Container(
              color: Colors.white,
              height: 80,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 24),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Chuyến đi',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Tab bar
            Container(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.black,
                indicatorColor: Colors.blue,
                tabs: const [
                  Tab(text: 'Sắp tới'),
                  Tab(text: 'Đã hoàn thành'),
                  Tab(text: 'Đã hủy'),
                ],
              ),
            ),
            // Hiển thị nút lọc chỉ khi ở tab "Sắp tới"
            if (_currentTabIndex == 0) _buildFilterButtons(),
            // Tab bar view
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildUpcomingTripList(), // Tab "Sắp tới"
                  _buildNoDataState(), // Tab "Đã hoàn thành"
                  _buildNoDataState(), // Tab "Đã hủy"
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
