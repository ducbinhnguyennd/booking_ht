import 'package:flutter/material.dart';

class TermsAndPolicyScreen extends StatelessWidget {
  const TermsAndPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header với nút Back và tiêu đề
            Container(
              color: Colors.white,
              height: 80,
              child: Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'Điều khoản và chính sách',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Nội dung chính
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Mục 1
                  _buildSectionTitle('1. Điều khoản sử dụng:'),
                  _buildBulletPoint(
                      'Người dùng khi sử dụng ứng dụng của Ban được xem như đã chấp nhận các điều kiện về việc đặt phòng, thanh toán, hủy đặt, chính sách hoàn tiền và các quy định khác liên quan đến việc sử dụng ứng dụng.'),
                  _buildBulletPoint(
                      'Bảo gồm các điều kiện về việc đặt phòng, thanh toán, hủy đặt, chính sách hoàn tiền và các quy định khác liên quan đến việc sử dụng ứng dụng.'),
                  const SizedBox(height: 16),

                  // Mục 2
                  _buildSectionTitle('2. Chính sách bảo mật:'),
                  _buildBulletPoint(
                      'Mọi thông tin được cung cấp bởi người dùng sẽ được bảo vệ và không được chia sẻ với bất kỳ bên thứ ba nào khác, trừ khi có sự đồng ý của người dùng.'),
                  _buildBulletPoint(
                      'Dữ liệu cá nhân của người dùng được bảo vệ theo quy định của luật hiện hành và các quy định GDPR hoặc CCPA (tùy theo phạm vi hoạt động của ứng dụng).'),
                  const SizedBox(height: 16),

                  // Mục 3
                  _buildSectionTitle('3. Chính sách thanh toán:'),
                  _buildBulletPoint(
                      'Đảm bảo rằng quy trình thanh toán an toàn và bảo vệ thông tin thanh toán của người dùng.'),
                  _buildBulletPoint(
                      'Liệt kê các phương thức thanh toán được chấp nhận và mọi quy trình xử lý tranh chấp.'),
                  const SizedBox(height: 16),

                  // Mục 4
                  _buildSectionTitle('4. Chính sách hủy đặt và hoàn tiền:'),
                  _buildBulletPoint(
                      'Dựa ra quy định về việc hủy đặt phòng và chính sách hoàn tiền.'),
                  _buildBulletPoint(
                      'Mô tả các điều kiện và khoản phí áp dụng.'),
                  const SizedBox(height: 16),

                  // Mục 5
                  _buildSectionTitle('5. Quyền lợi và trách nhiệm:'),
                  _buildBulletPoint(
                      'Dựa ra quy trình giải quyết tranh chấp giữa người dùng và nhà cung cấp dịch vụ khách sạn.'),
                  _buildBulletPoint(
                      'Mô tả quy trình khiếu nại và giải quyết tranh chấp bao gồm các liên hệ với đội ngũ trợ giúp.'),
                  const SizedBox(height: 16),

                  // Mục 6
                  _buildSectionTitle('6. Điều khoản bổ sung:'),
                  _buildBulletPoint(
                      'Bao gồm các điều khoản bổ sung khác mà người dùng cần biết, chẳng hạn như quyền sở hữu trí tuệ, giới hạn trách nhiệm, bất khả kháng và quyền áp dụng pháp luật.'),
                  const SizedBox(height: 24),

                  // Nút "Đã hiểu"
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Quay lại màn hình trước
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Màu nền nút
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Đã hiểu',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Hàm tạo tiêu đề mục
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Hàm tạo gạch đầu dòng
  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(fontSize: 16),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
