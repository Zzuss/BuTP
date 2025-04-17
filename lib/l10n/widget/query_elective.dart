import 'package:flutter/material.dart';
import 'package:flutter01/l10n/model/course.dart';
import 'package:flutter01/l10n/services/mock_api_service.dart';

class QueryElective extends StatefulWidget {
  const QueryElective({super.key});

  @override
  State<QueryElective> createState() => _QueryElectiveState();
}

class _QueryElectiveState extends State<QueryElective> {
  bool _isLoading = false;
  List<Course>? _courses;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchElectiveCourses();
  }

  Future<void> _fetchElectiveCourses() async {
    setState(() {
      _isLoading = true;
      _courses = null;
      _errorMessage = null;
    });

    try {
      final courses = await MockApiService.getElectiveCourses();
      setState(() {
        _courses = courses;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = '查询失败: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '全校选修课列表', 
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: _isLoading ? null : _fetchElectiveCourses,
                tooltip: '刷新',
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else if (_errorMessage != null)
            Center(child: Text(_errorMessage!, style: const TextStyle(color: Colors.red)))
          else if (_courses != null && _courses!.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: _courses!.length,
                itemBuilder: (context, index) {
                  final course = _courses![index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8.0),
                    child: ExpansionTile(
                      title: Text(course.courseName),
                      subtitle: Text('${course.courseId} | 学分: ${course.credit}'),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('分类: ${course.category}'),
                              Text('总学时: ${course.totalHours}'),
                              Text('理论学时: ${course.theoryHours}'),
                              Text('实践学时: ${course.practiceHours}'),
                              Text('学期: ${course.semester}'),
                              Text('考核方式: ${course.examType}'),
                              if (course.remarks != null) Text('备注: ${course.remarks}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          else
            const Center(child: Text('没有找到选修课程')),
        ],
      ),
    );
  }
} 