import 'package:flutter/material.dart';
import '../models/member.dart';

class MemberScreenV2 extends StatelessWidget {
  const MemberScreenV2({super.key});

  @override
  Widget build(BuildContext context) {
    // Dữ liệu mẫu cứng
    final List<Member> members = [
      Member(name: 'An', description: 'Học sinh chăm chỉ'),
      Member(name: 'Bình', description: 'Giỏi toán'),
      Member(name: 'Chi', description: 'Thích vẽ'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách thành viên'),
        centerTitle: true,
        backgroundColor: const Color(0xFF7E57C2),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Form nhập liệu (giống V1)
            const TextField(
              decoration: InputDecoration(
                labelText: 'Tên',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Mô tả',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7E57C2),
                foregroundColor: Colors.white,
              ),
              child: const Text('Thêm thành viên'),
            ),

            const SizedBox(height: 24),

            // Tiêu đề danh sách
            const Text(
              'Danh sách:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Danh sách thành viên
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (final member in members)
                      Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(member.name[0].toUpperCase()),
                          ),
                          title: Text(member.name),
                          subtitle: Text(member.description),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}