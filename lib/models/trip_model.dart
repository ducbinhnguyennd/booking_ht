class Trip {
  final String hotelName;
  final String roomType;
  final String status; // "upcoming", "completed", "canceled"
  final bool isConfirmed; 

  Trip({
    required this.hotelName,
    required this.roomType,
    required this.status,
    this.isConfirmed = false,
  });
}