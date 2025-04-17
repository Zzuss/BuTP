// widgets/query_by_course_id.dart
import 'package:flutter/material.dart';
// import 'package:flutter01/l10n/services/api_services.dart';
import 'package:flutter01/l10n/services/api_services.dart';
import 'package:flutter01/l10n/model/course.dart';

class QueryByCourseId extends StatefulWidget {
  const QueryByCourseId({super.key});

  @override
  _QueryByCourseIdState createState() => _QueryByCourseIdState();
}

class _QueryByCourseIdState extends State<QueryByCourseId> {
  final TextEditingController _controller = TextEditingController();
  Course? course;
  bool isLoading = false;
  String? error;

  Future<void> _fetchData() async {
    final id = _controller.text.trim();
    if (id.isEmpty) return;

    setState(() {
      isLoading = true;
      error = null;
      course = null;
    });

    try {

      final result = await ApiService.getCourseById(id);
      setState(() {
        course = result;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: '输入课号',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _fetchData,
            child: const Text('查询'),
          ),
          const SizedBox(height: 20),
          if (isLoading) const CircularProgressIndicator(),
          if (error != null) Text('错误: $error', style: const TextStyle(color: Colors.red)),
          if (course != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('课程名称: ${course!.courseName}', style: const TextStyle(fontSize: 18)),
                    Text('分类: ${course!.category}'),
                    Text('学分: ${course!.credit}'),
                    Text('总学时: ${course!.totalHours}'),
                    Text('理论学时: ${course!.theoryHours}'),
                    Text('实践学时: ${course!.practiceHours}'),
                    Text('学期: ${course!.semester}'),
                    Text('是否必修: ${course!.required}'),
                    Text('考核方式: ${course!.examType}'),
                    if (course!.remarks != null) Text('备注: ${course!.remarks}'),
                    Text('专业: ${course!.major}'),
                    Text('年级: ${course!.year}'),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}