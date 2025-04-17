// services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter01/l10n/model/course.dart';


class ApiService {
  static const String _baseUrl = 'https://localhost:8080/';

  // // 按分类查询
  // static Future<Map<String, dynamic>> getCoursesByCategory(String category) async {
  //   final response = await http.get(Uri.parse('$_baseUrl/courses/category/$category'));
  //
  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     return {
  //       'requirement': CategoryRequirement.fromJson(data['requirement']),
  //       'courses': (data['courses'] as List).map((e) => Course.fromJson(e)).toList(),
  //     };
  //   } else {
  //     throw Exception('Failed to load courses by category');
  //   }
  // }

  // 按课号查询
  static Future<Course> getCourseById(String id) async {
    if (id.isEmpty) {
      throw Exception('课号不能为空');
    }

    final response = await http.get(Uri.parse('$_baseUrl/courses/$id'));
    print('状态码: ${response.statusCode}');
    print('响应头: ${response.headers}');
    print('响应体: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data == null) {
        throw Exception('未找到该课程信息');
      }
      
      print('解析后的数据: $data');
      
      // 验证必需字段
      final requiredFields = [
        'courseId', 'category', 'courseName', 'credit', 'totalHours',
        'theoryHours', 'practiceHours', 'semester', 'required',
        'examType', 'major', 'year'
      ];
      
      for (final field in requiredFields) {
        print('检查字段 $field: ${data[field]}');
        if (data[field] == null) {
          throw Exception('缺少必需字段: $field');
        }
      }
      
      return Course.fromJson(data);
    } else if (response.statusCode == 404) {
      throw Exception('未找到该课程');
    } else {
      throw Exception('查询课程失败: ${response.statusCode}');
    }
  }

  // 按年级查询
  static Future<List<Course>> getCoursesByGrade(int grade) async {
    final response = await http.get(Uri.parse('$_baseUrl/courses/grade/$grade'));

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List).map((e) => Course.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load courses by grade');
    }
  }

//   // 按选修课查询
//   static Future<List<Course>> getElectiveCourses() async {
//     final response = await http.get(Uri.parse('$_baseUrl/courses/elective'));
//
//     if (response.statusCode == 200) {
//       return (json.decode(response.body) as List).map((e) => Course.fromJson(e)).toList();
//     } else {
//       throw Exception('Failed to load elective courses');
//     }
//   }
 }