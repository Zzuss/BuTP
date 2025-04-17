// screens/home_screen.dart
import 'package:flutter/material.dart';
//import '../widgets/query_by_category.dart';
import 'package:flutter01/l10n/widget/query_by_course_id.dart';
import 'package:flutter01/l10n/widget/query_by_grade.dart';
import 'package:flutter01/l10n/widget/query_elective.dart';
import 'package:flutter01/l10n/widget/query_by_category.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('课程查询系统'),
          bottom: const TabBar(
            tabs: [
              Tab(text: '按分类查询'),
              Tab(text: '按课号查询'),
              Tab(text: '按年级查询'),
              Tab(text: '选修课查询'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            QueryByCategory(),
            QueryByCourseId(),
            QueryByGrade(),
            QueryElective(),
          ],
        ),
      ),
    );
  }
}