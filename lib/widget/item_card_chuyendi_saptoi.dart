import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:booking_hotel/apiservice/api_service.dart';
import 'package:booking_hotel/models/trip_model.dart';

class TripCardSapToi extends StatelessWidget {
  final Trip trip;
  final bool isCancelled;
  final VoidCallback? onCancel;

  const TripCardSapToi({
    Key? key,
    required this.trip,
    this.isCancelled = false,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (trip.hotelImages.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.memory(
                  base64Decode(trip.hotelImages[0].split(',').last),
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 150,
                      color: Colors.grey,
                      child: const Center(child: Text('Ảnh không tải được')),
                    );
                  },
                ),
              ),
            const SizedBox(height: 8),
            Text(trip.hotelName,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('Phòng: ${trip.roomName}'),
            Text('Nhận: ${trip.ngayNhan.toLocal().toString().split(" ")[0]}'),
            Text('Trả: ${trip.ngayTra.toLocal().toString().split(" ")[0]}'),
            Text('Tổng tiền: ${trip.tongTien}đ'),
            if (!isCancelled)
              TextButton(
                onPressed: () async {
                  try {
                    // Hiển thị loading khi bắt đầu hủy
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const Center(child: CircularProgressIndicator()),
                    );

                    await ApiService().cancelTrip(trip.id);
                    if (onCancel != null) onCancel!(); // Gọi lại fetchTrips

                    // Đóng dialog và thông báo thành công
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Hủy đặt thành công!')),
                    );
                  } catch (e) {
                    // Đóng dialog nếu có lỗi
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Lỗi khi hủy: $e')),
                    );
                  }
                },
                child: const Text('Hủy đặt'),
              ),
            if (isCancelled)
              const Text('Đã hủy', style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}