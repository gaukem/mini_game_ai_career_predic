import 'package:flutter/material.dart';
import '../models/member.dart';

class MemberScreenV3 extends StatefulWidget {
  const MemberScreenV3({super.key});

  @override
  State<MemberScreenV3> createState() => _MemberScreenV3State();
}

class _MemberScreenV3State extends State<MemberScreenV3> {
  // BIẾN TRẠNG THÁI - sẽ thay đổi theo thời gian
  List<Member> _members = [];

  // CONTROLLER - để đọc giá trị từ TextField
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  // HÀM THÊM THÀNH VIÊN
  // Hàm thêm thành viên với loading
Future<void> _addMember() async {
  final name = _nameController.text.trim();
  final desc = _descController.text.trim();

  if (name.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Vui lòng nhập tên!')),
    );
    return;
  }

  // HIỂN THỊ LOADING MODAL
  showDialog(
    context: context,
    barrierDismissible: false,  // Không đóng khi nhấn bên ngoài
    builder: (context) {
      return const PopScope(
        canPop: false,  // Không cho phép back
        child: Center(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      );
    },
  );

  // GIẢ LẬP DELAY 3 GIÂY (thay bằng gọi API thực tế)
  await Future.delayed(const Duration(seconds: 3));

  // KIỂM TRA WIDGET CÒN TỒN TẠI KHÔNG
  if (!mounted) return;

  // ĐÓNG LOADING MODAL
  Navigator.of(context).pop();

  final newMember = Member(
    name: name,
    description: desc.isEmpty ? 'Chưa có mô tả' : desc,
  );

  setState(() {
    _members = [..._members, newMember];
  });

  _nameController.clear();
  _descController.clear();
}

  @override
  void dispose() {
    // Giải phóng controller khi widget bị hủy
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

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
            // Form với Controller
            TextField(
              controller: _nameController,  // Gắn controller
              decoration: const InputDecoration(
                labelText: 'Tên',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descController,  // Gắn controller
              decoration: const InputDecoration(
                labelText: 'Mô tả',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _addMember,  // Gọi hàm khi nhấn
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7E57C2),
                foregroundColor: Colors.white,
              ),
              child: const Text('Thêm thành viên'),
            ),

            const SizedBox(height: 24),

            const Text(
              'Danh sách:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Danh sách động
            Expanded(
              child: _members.isEmpty
                  ? const Center(child: Text('Chưa có thành viên nào'))
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          for (final member in _members)
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