import 'package:flutter01/l10n/model/converter/datatime_converter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter01/l10n/services/api_services.dart';

// 注意：默认方式不用加路径 "generated"。
// part 'user.g.dart';
//part 'l10n/model/generated/course.g.dart';  // 确保与生成的路径一致

//@JsonSerializable(converters: [DataTimeConverter()])
class Course {
  final String courseId;
  final String category;
  final String courseName;
  final double credit;
  final double totalHours;
  final double theoryHours;
  final double practiceHours;
  final int semester;
  final String required;
  final String examType;
  final String? remarks;
  final String major;
  final int year;

  // final DateTime createAt;
  // final DateTime updateAt;


  Course({
    required this.courseId,
    required this.category,
    required this.courseName,
    required this.credit,
    required this.totalHours,
    required this.theoryHours,
    required this.practiceHours,
    required this.semester,
    required this.required,
    required this.examType,
    this.remarks,
    required this.major,
    required this.year,
    // this.createAt,
    // this.updateAt,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      courseId: json['courseId'],
      category: json['category'],
      courseName: json['courseName'],
      credit: (json['credit'] is int) ? (json['credit'] as int).toDouble() : json['credit'],
      totalHours: (json['totalHours'] is int) ? (json['totalHours'] as int).toDouble() : json['totalHours'],
      theoryHours: (json['theoryHours'] is int) ? (json['theoryHours'] as int).toDouble() : json['theoryHours'],
      practiceHours: (json['practiceHours'] is int) ? (json['practiceHours'] as int).toDouble() : json['practiceHours'],
      semester: json['semester'],
      required: json['required'],
      examType: json['examType'],
      remarks: json['remarks'],
      major: json['major'],
      year: json['year'],
      // createAt: json['createAt'] is String
      //     ? DateTime.parse(json['createAt'])
      //     : (json['createAt'] is DateTime ? json['createAt'] : DateTime.now()),
      // updateAt: json['updateAt'] is String
      //     ? DateTime.parse(json['updateAt'])
      //     : (json['updateAt'] is DateTime ? json['updateAt'] : DateTime.now()),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'courseId': courseId,
      'category': category,
      'courseName': courseName,
      'credit': credit,
      'totalHours': totalHours,
      'theoryHours': theoryHours,
      'practiceHours': practiceHours,
      'semester': semester,
      'required': required,
      'examType': examType,
      'remarks': remarks,
      'major': major,
      'year': year,
      // 'createAt': createAt.toIso8601String(),
      // 'updateAt': updateAt.toIso8601String(),
    };
  }
}
