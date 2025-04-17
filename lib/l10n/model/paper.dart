// import 'dart:convert';
// import 'package:flutter01/l10n/widget/consts.dart';
// import 'package:flutter01/common/helper.dart';
// import 'package:flutter01/l10n/model/generated/model.dart';
//
// class Paper<T> extends Model<Paper<T>>{
//   final int page;
//   final int pageSize;
//   final int totalSize;
//   final int totalPage;
//   final List<T>? items;
//
//   const Paper({
//     required this.page,
//     required this.pageSize,
//     required this.totalSize,
//     required this.totalPage,
//     this.items,
// });
//
//   bool get isEmpty => Helper.isEmpty(items);
//
//   factory Paper.fromJson(Map<String, dynamic> json) {
//     final List<Map<String, dynamic>>? items = json["items"];
//     return Paper(page: json["page"] ?? 0,
//         pageSize: json["pageSize"] ?? 0,
//         totalSize: json ["totalSize"]?? 0,
//         totalPage: json ["totalPage"]?? 0,
//         items: items?.map((e) => converter(e)).toList(),
//     );
//   }
//
//   }
//   @override
//   Map<String, dynamic> toJson() {
//     return{
//     "page": page,
//     "pageSize": pageSize, "totalSize": totalSize,"totalPage": totalPage,
//     "items": items?.map((e) => e.toString()).toList(),
//     };
// }