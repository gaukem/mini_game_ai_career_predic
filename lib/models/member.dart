class Member {
  final String name;        // Tên người dùng
  final String description; // Đặc điểm
  String? idealJob;         // Kết quả gợi ý từ AI (có thể null)

  Member({
    required this.name,
    required this.description,
    this.idealJob,
  });
}