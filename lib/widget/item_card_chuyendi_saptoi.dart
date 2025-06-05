import 'package:booking_hotel/apiservice/api_service.dart';
import 'package:flutter/material.dart';
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
            Text(trip.hotelName,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('Phòng: ${trip.roomName}'),
            Text('Nhận: ${trip.ngayNhan.toLocal().toString().split(" ")[0]}'),
            Text('Trả: ${trip.ngayTra.toLocal().toString().split(" ")[0]}'),
            Text('Tổng tiền: ${trip.tongTien}đ'),
            if (!isCancelled)
              TextButton(
                onPressed: () async {
                  try {
                    await ApiService().cancelTrip(trip.id);
                    if (onCancel != null) onCancel!();
                  } catch (e) {
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
