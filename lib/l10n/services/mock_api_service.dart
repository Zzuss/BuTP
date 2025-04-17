import 'dart:convert';
import 'package:flutter01/l10n/model/course.dart';

class MockApiService {
  // 模拟获取课程按ID
  static Future<Course> getCourseById(String id) async {
    // 模拟网络延迟
    await Future.delayed(const Duration(milliseconds: 800));
    
    // 返回假数据
    return Course(
      courseId: id,
      category: '专业必修课',
      courseName: '模拟课程 $id',
      credit: 4.0,
      totalHours: 64.0,
      theoryHours: 48.0,
      practiceHours: 16.0,
      semester: 1,
      required: '必修',
      examType: '考试',
      remarks: '这是一个模拟课程',
      major: '计算机科学与技术',
      year: 2023,
      // createAt: DateTime.now(),
      // updateAt: DateTime.now(),
    );
  }

  // 模拟按年级获取课程
  static Future<List<Course>> getCoursesByGrade(int grade) async {
    // 模拟网络延迟
    await Future.delayed(const Duration(milliseconds: 800));
    
    // 返回假课程列表
    List<Course> courses = [];
    for (int i = 1; i <= 10; i++) {
      courses.add(Course(
        courseId: 'CS${grade}0$i',
        category: i % 2 == 0 ? '专业必修课' : '专业选修课',
        courseName: '${grade}年级模拟课程 $i',
        credit: (i % 3 + 2).toDouble(),
        totalHours: (i % 2 + 3) * 16.0,
        theoryHours: (i % 2 + 2) * 12.0,
        practiceHours: i * 4.0,
        semester: (i % 2) + 1,
        required: i % 3 == 0 ? '选修' : '必修',
        examType: i % 2 == 0 ? '考试' : '考查',
        remarks: i % 2 == 0 ? '这是一个模拟课程' : null,
        major: '计算机科学与技术',
        year: 2023,
        // createAt: DateTime.now(),
        // updateAt: DateTime.now(),
      ));
    }
    return courses;
  }

  // 模拟获取选修课
  static Future<List<Course>> getElectiveCourses() async {
    // 模拟网络延迟
    await Future.delayed(const Duration(milliseconds: 800));
    
    // 返回假选修课列表
    List<Course> courses = [];
    for (int i = 1; i <= 8; i++) {
      courses.add(Course(
        courseId: 'EL00$i',
        category: '公共选修课',
        courseName: '选修模拟课程 $i',
        credit: 2.0,
        totalHours: 32.0,
        theoryHours: 24.0,
        practiceHours: 8.0,
        semester: i % 2 + 1,
        required: '选修',
        examType: '考查',
        remarks: '这是一个模拟选修课',
        major: '通识教育',
        year: 2023,
        // createAt: DateTime.now(),
        // updateAt: DateTime.now(),
      ));
    }
    return courses;
  }

  // 模拟按分类查询课程
  static Future<Map<String, dynamic>> getCoursesByCategory(String category) async {
    // 模拟网络延迟
    await Future.delayed(const Duration(milliseconds: 800));
    
    // 生成按分类的课程
    List<Course> courses = [];
    for (int i = 1; i <= 6; i++) {
      courses.add(Course(
        courseId: '${category.substring(0, 2).toUpperCase()}00$i',
        category: category,
        courseName: '$category模拟课程 $i',
        credit: 3.0,
        totalHours: 48.0,
        theoryHours: 32.0,
        practiceHours: 16.0,
        semester: i % 2 + 1,
        required: category.contains('必修') ? '必修' : '选修',
        examType: i % 2 == 0 ? '考试' : '考查',
        remarks: i % 2 == 0 ? '这是一个$category模拟课程' : null,
        major: '计算机科学与技术',
        year: 2023,
        // createAt: DateTime.now(),
        // updateAt: DateTime.now(),
      ));
    }

    return {
      'requirement': {
        'category': category,
        'minCredits': 12.0,
        'description': '$category的课程要求说明'
      },
      'courses': courses,
    };
  }
} 