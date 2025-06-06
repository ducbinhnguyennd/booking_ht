class Room {
  final String tenPhong;
  final double giaTien;
  final List<String> anhPhong;

  Room({
    required this.tenPhong,
    required this.giaTien,
    required this.anhPhong,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      tenPhong: json['tenPhong'] ?? '',
      giaTien: (json['giaTien'] ?? 0).toDouble(),
      anhPhong: List<String>.from(json['anhPhong'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tenPhong': tenPhong,
      'giaTien': giaTien,
      'anhPhong': anhPhong,
    };
  }
}

class Hotel {
  final String id;
  final String tenKhachSan;
  final String diaChi;
  final List<String> anhKhachSan;
  final List<Room> danhSachPhong;
  final String type;

  Hotel({
    required this.id,
    required this.tenKhachSan,
    required this.diaChi,
    required this.anhKhachSan,
    required this.danhSachPhong,
    required this.type,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['_id'] ?? '',
      tenKhachSan: json['tenKhachSan'] ?? '',
      diaChi: json['diaChi'] ?? '',
      anhKhachSan: List<String>.from(json['anhKhachSan'] ?? []),
      danhSachPhong: (json['danhSachPhong'] as List<dynamic>?)
              ?.map((room) => Room.fromJson(room))
              .toList() ??
          [],
      type: json['type'] ?? 'all',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'tenKhachSan': tenKhachSan,
      'diaChi': diaChi,
      'anhKhachSan': anhKhachSan,
      'danhSachPhong': danhSachPhong.map((room) => room.toJson()).toList(),
      'type': type,
    };
  }
}
