class Trip {
  final String id;
  final String hotelName;
  final List<String> hotelImages; // Thêm danh sách ảnh khách sạn
  final String roomName;
  final String roomType; // Thêm loại phòng
  final DateTime ngayNhan;
  final DateTime ngayTra;
  final int tongTien;
  final String status;

  Trip({
    required this.id,
    required this.hotelName,
    required this.hotelImages,
    required this.roomName,
    required this.roomType,
    required this.ngayNhan,
    required this.ngayTra,
    required this.tongTien,
    required this.status,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['_id']?.toString() ?? '',
      hotelName:
          json['khachSan'] != null && json['khachSan']['tenKhachSan'] != null
              ? json['khachSan']['tenKhachSan'].toString()
              : 'Unknown Hotel',
      hotelImages:
          json['khachSan'] != null && json['khachSan']['anhKhachSan'] != null
              ? List<String>.from(json['khachSan']['anhKhachSan'])
              : [],
      roomName: json['tenPhong']?.toString() ?? 'Unknown Room',
      roomType: json['loaiPhong']?.toString() ?? 'Unknown Type',
      ngayNhan: DateTime.tryParse(json['ngayNhan']?.toString() ?? '') ??
          DateTime.now(),
      ngayTra: DateTime.tryParse(json['ngayTra']?.toString() ?? '') ??
          DateTime.now(),
      tongTien: (json['tongTien'] as num?)?.toInt() ?? 0,
      status: json['trangThai']?.toString() ?? 'chờ xác nhận',
    );
  }
}
