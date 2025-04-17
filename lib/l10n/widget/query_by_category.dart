import 'package:flutter/material.dart';
import 'package:flutter01/l10n/model/course.dart';
import 'package:flutter01/l10n/services/mock_api_service.dart';

class QueryByCategory extends StatefulWidget {
  const QueryByCategory({super.key});

  @override
  State<QueryByCategory> createState() => _QueryByCategoryState();
}

class _QueryByCategoryState extends State<QueryByCategory> {
  final _categories = [
    '专业必修课',
    '专业选修课',
    '通识必修课',
    '通识选修课',
  ];
  
  String _selectedCategory = '专业必修课';
  bool _isLoading = false;
  Map<String, dynamic>? _result;
  String? _errorMessage;

  Future<void> _queryByCategory() async {
    setState(() {
      _isLoading = true;
      _result = null;
      _errorMessage = null;
    });

    try {
      final data = await MockApiService.getCoursesByCategory(_selectedCategory);
      setState(() {
        _result = data;
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
          DropdownButtonFormField<String>(
            value: _selectedCategory,
            decoration: const InputDecoration(
              labelText: '选择课程分类',
              border: OutlineInputBorder(),
            ),
            items: _categories.map((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedCategory = newValue;
                });
              }
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _isLoading ? null : _queryByCategory,
            child: _isLoading 
                ? const CircularProgressIndicator(strokeWidth: 2)
                : const Text('查询'),
          ),
          const SizedBox(height: 16),
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else if (_errorMessage != null)
            Center(child: Text(_errorMessage!, style: const TextStyle(color: Colors.red)))
          else if (_result != null)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('分类: ${_result!['requirement']['category']}', 
                              style: Theme.of(context).textTheme.titleMedium),
                          Text('最低学分: ${_result!['requirement']['minCredits']}'),
                          Text('说明: ${_result!['requirement']['description']}'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('课程列表', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: (_result!['courses'] as List).length,
                      itemBuilder: (context, index) {
                        final course = (_result!['courses'] as List)[index] as Course;
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8.0),
                          child: ListTile(
                            title: Text(course.courseName),
                            subtitle: Text('${course.courseId} | 学分: ${course.credit} | 学时: ${course.totalHours}'),
                            trailing: Text(course.required),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
} 