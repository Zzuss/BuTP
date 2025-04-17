// widgets/query_by_grade.dart
import 'package:flutter/material.dart';
// import 'package:flutter01/l10n/services/api_services.dart';
import 'package:flutter01/l10n/services/mock_api_service.dart';
import 'package:flutter01/l10n/model/course.dart';

class QueryByGrade extends StatefulWidget {
  const QueryByGrade({super.key});

  @override
  _QueryByGradeState createState() => _QueryByGradeState();
}

class _QueryByGradeState extends State<QueryByGrade> {
  int? selectedGrade;
  List<Course> courses = [];
  bool isLoading = false;
  String? error;

  final List<int> grades = [2020, 2021, 2022, 2023, 2024]; // 示例年级

  Future<void> _fetchData() async {
    if (selectedGrade == null) return;

    setState(() {
      isLoading = true;
      error = null;
      courses = [];
    });

    try {
      // 使用模拟API服务而不是真实API
      final result = await MockApiService.getCoursesByGrade(selectedGrade!);
      setState(() {
        courses = result;
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          DropdownButton<int>(
            value: selectedGrade,
            hint: const Text('选择年级'),
            items: grades.map((grade) {
              return DropdownMenuItem(
                value: grade,
                child: Text('$grade 年级'),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedGrade = value;
              });
              _fetchData();
            },
          ),
          const SizedBox(height: 20),
          if (isLoading) const CircularProgressIndicator(),
          if (error != null) Text('错误: $error', style: const TextStyle(color: Colors.red)),
          Expanded(
            child: courses.isEmpty 
                ? const Center(child: Text('请选择年级查询课程'))
                : ListView.builder(
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      final course = courses[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ExpansionTile(
                          title: Text(course.courseName),
                          subtitle: Text('课号: ${course.courseId} | 学分: ${course.credit}'),
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
                                  Text('是否必修: ${course.required}'),
                                  Text('考核方式: ${course.examType}'),
                                  if (course.remarks != null) Text('备注: ${course.remarks}'),
                                  Text('专业: ${course.major}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}