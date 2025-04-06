import 'package:flutter/material.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TicketWidget(),
        ),
      ),
    );
  }
}

class TicketWidget extends StatelessWidget {
  const TicketWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Hiệu ứng cắt hai bên
          Positioned(
            left: -20,
            top: 0,
            bottom: 0,
            child: ClipPath(
              clipper: TicketClipper(),
              child: Container(
                width: 40,
                color: Colors.grey[200], // Màu nền của Scaffold
              ),
            ),
          ),
          Positioned(
            right: -20,
            top: 0,
            bottom: 0,
            child: ClipPath(
              clipper: TicketClipper(),
              child: Container(
                width: 40,
                color: Colors.grey[200], // Màu nền của Scaffold
              ),
            ),
          ),
          // Nội dung chính của ticket
          Column(
            children: [
              // Phần trên
              Expanded(
                child: Stack(
                  children: [
                    // Văn bản xoay ở các cạnh
                    Positioned(
                      left: -50,
                      top: 50,
                      child: Transform.rotate(
                        angle: -1.5708, // Xoay 90 độ ngược chiều kim đồng hồ
                        child: const Text(
                          'EA MUZZER NU tickets',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ),
                    Positioned(
                      right: -50,
                      top: 50,
                      child: Transform.rotate(
                        angle: 1.5708, // Xoay 90 độ theo chiều kim đồng hồ
                        child: const Text(
                          'EA MUZZER NU tickets',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 0,
                      right: 0,
                      child: Transform.rotate(
                        angle: 0,
                        child: const Text(
                          'EA MUZZER NU tickets',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Transform.rotate(
                        angle: 3.1416, // Xoay 180 độ
                        child: const Text(
                          'telen hetaonura Nearam',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ),
                    // Hình con bướm
                    Center(
                      child: Icon(
                        Icons
                            .flutter_dash, // Thay bằng hình ảnh con bướm nếu có
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              // Đường nét đứt ngang
              CustomPaint(
                painter: DashedLinePainter(),
                child: const SizedBox(
                  height: 1,
                  width: double.infinity,
                ),
              ),
              // Phần dưới
              Expanded(
                child: Container(
                  color: Colors.white.withOpacity(0.5), // Màu nền nhạt
                ),
              ),
              // Đường viền nét đứt dưới cùng
              CustomPaint(
                painter: DottedLinePainter(),
                child: const SizedBox(
                  height: 20,
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Clipper để tạo hiệu ứng cắt hai bên
class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.addOval(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: 20,
      ),
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Vẽ đường nét đứt ngang
class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const dashWidth = 5;
    const dashSpace = 5;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Vẽ đường viền nét đứt dưới cùng (hình tròn)
class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    const dotRadius = 3;
    const dotSpace = 5;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawCircle(
        Offset(startX + dotRadius, size.height / 2),
        dotRadius as double,
        paint,
      );
      startX += (dotRadius * 2) + dotSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
