// import 'dart:convert';
// import 'package:flutter01/l10n/model/generated/model.dart';
// import 'package:flutter01/common/helper.dart';
// import 'package:flutter01/l10n/widget/consts.dart';
// class Result{
//   final int code;
//   final String message;
//   final dynamic data;
//
//   Result({
//     required this.code,
//     required this.message,
//     required this.data,
// });
//
//   Result.of(this.code, {String? message})
//      : data =null,
//       message = message ?? StatusCode.getLabel(code) ??"Unknown";
//   bool get success => code == 200;
//    ///用于判断业务是否处理成功
//   bool get success => code == Consts.request.successCode;
//
//    ///用于判断当前响应的数据谁否是列表
//   bool get isArray => !isEmpty && data is Iterable;
//
//    ///用于判断当时数据是否为空
//   bool get isEmpty => Helper.isEmpty(data);
//
//    ///用于获取当前数据的条数
//   int get size => isEmpty ?0: (isArray ? data.length :1);
//
//    ///用于将返回的统一数据转换成指定的数据类型，数据类型由 [converter] 决定；
//    T toModel<T>(Converter<T>  converter) => converter(data);
//
//    ///用于将当前数据转换成指定类型的列表，具体数据类型由 [converter] 决定。
//    List<T> toArray<T>(Converter<T>  converter) {
//      if(isEmpty)return<T>[];
//      if(isArray) {
//        return data.map<T>((e) => converter(e)).toList();
//      }
//      return<T>[converter(data)];
//    }
//
//   factory Result.fromJson(Map<String, dynamic> json) {
//     return Result(code: json["code"] ?? 0, message: json["message"] ?? "", data: json ["data"]);
//   }
//
//   }
//   Map<String, dynamic> toJson() {
//     return{
//     "code":200,// 页码码（码值由服务端定义）
//     "message":"OK",// 请求对应的服务端消息（成功或失败，以及失败的原因）
//     "data": data.toString(),
//     };
// }