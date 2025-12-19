import 'package:flutter/material.dart';

class MemberScreenV1 extends StatelessWidget {
  const MemberScreenV1({super.key});

  @override
  Widget build(BuildContext context) {
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
            // Ô nhập Tên
            const TextField(
              decoration: InputDecoration(
                labelText: 'Tên',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            
            // Ô nhập Mô tả
            const TextField(
              decoration: InputDecoration(
                labelText: 'Mô tả',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            
            // Nút bấm
            ElevatedButton(
              onPressed: () {
                // Chưa làm gì cả
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7E57C2),
                foregroundColor: Colors.white,
              ),
              child: const Text('Thêm thành viên'),
            ),
          ],
        ),
      ),
    );
  }
}

