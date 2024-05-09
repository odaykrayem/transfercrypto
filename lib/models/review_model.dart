// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReviewModel {
  final int id;
  final String user_name;
  final String? content;
  final double rating;
  final String? date;

  final DateTime created_at;
  final DateTime updated_at;

  ReviewModel({
    required this.id,
    required this.user_name,
    this.content,
    required this.rating,
    this.date,
    required this.created_at,
    required this.updated_at,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_name': user_name,
      'content': content,
      'rating': rating,
      'date': date,
      'created_at': created_at.toString(),
      'updated_at': updated_at.toString(),
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    debugPrint('usr:::: ${map['date']}');
    return ReviewModel(
      id: map['id'] as int,
      user_name:
          '${map['user']['f_name'] as String} ${map['user']['l_name'] as String}',
      content: map['content'] != null ? map['content'] as String : '',
      rating: double.parse('${map['rating']}'),
      date: map['date'] as String,
      created_at: DateFormat('yyyy-MM-dd hh:mm').parse(
          DateTime.parse(map['created_at'] as String).toLocal().toString()),
      // created_at: DateFormat("y-M-d HH:mm:ss")
      //     .parse((DateTime.parse(map['created_at'] as String)).toString()),
      updated_at: DateUtils.dateOnly(DateFormat("yyyy-MM-dd")
          .parse(DateTime.parse(map['updated_at'] as String).toString())),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewModel.fromJson(String source) =>
      ReviewModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
