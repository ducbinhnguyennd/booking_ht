import 'package:booking_hotel/constant/asset_path_const.dart';
import 'package:booking_hotel/constant/colors_const.dart';
import 'package:booking_hotel/models/trip_model.dart';
import 'package:flutter/material.dart';

class TripCardSapToi extends StatelessWidget {
  final Trip trip;

  const TripCardSapToi({
    Key? key,
    required this.trip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 16),
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
                          color: _getStatusColor(),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(_getStatusIcon(),
                                size: 20, color: _getTextColor()),
                            const SizedBox(width: 8),
                            Text(
                              _getStatusText(),
                              style: TextStyle(
                                color: _getTextColor(),
                                fontSize: 12,
                              ),
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
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor() {
    switch (trip.status) {
      case "upcoming":
        return trip.isConfirmed ? Colors.orange[100]! : Colors.blue[100]!;
      case "completed":
        return Colors.green[100]!;
      case "canceled":
        return Colors.red[100]!;
      default:
        return Colors.grey[100]!;
    }
  }

  IconData _getStatusIcon() {
    switch (trip.status) {
      case "upcoming":
        return trip.isConfirmed ? Icons.access_time : Icons.favorite_border;
      case "completed":
        return Icons.check_circle;
      case "canceled":
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  Color _getTextColor() {
    switch (trip.status) {
      case "upcoming":
        return trip.isConfirmed ? Colors.orange[800]! : Colors.blue;
      case "completed":
        return Colors.green[800]!;
      case "canceled":
        return Colors.red[800]!;
      default:
        return Colors.black;
    }
  }

  String _getStatusText() {
    switch (trip.status) {
      case "upcoming":
        return trip.isConfirmed ? "Chỗ xác nhận" : "Muốn đến";
      case "completed":
        return "Đã hoàn thành";
      case "canceled":
        return "Đã hủy";
      default:
        return "Không xác định";
    }
  }

  Widget _buildActionButtons(BuildContext context) {
    if (trip.status == "upcoming" && trip.isConfirmed) {
      return Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: Colors.grey,
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildButton(context, "Hủy đặt phòng", Colors.white, Colors.blue),
              _buildButton(context, "Xem hóa đơn", Colors.blue, Colors.white),
            ],
          ),
        ],
      );
    } else if (trip.status == "upcoming" && !trip.isConfirmed) {
      return Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: Colors.grey,
          ),
          const SizedBox(height: 15),
          _buildButton(context, "Đặt phòng ngay!", Colors.blue, Colors.white,
              widthFactor: 2),
        ],
      );
    }

    return const SizedBox
        .shrink(); // Không hiển thị nút cho "completed" và "canceled"
  }

  Widget _buildButton(
      BuildContext context, String text, Color bgColor, Color textColor,
      {double widthFactor = 3}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      width: MediaQuery.of(context).size.width / widthFactor,
      height: 35,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 12),
        ),
      ),
    );
  }
}
