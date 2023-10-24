// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionModel {
  final int id;
  final int user_id;
  final double send_amount;
  final double receive_amount;
  final double commission;
  final String from_wallet;
  final String from_wallet_icon;
  final String to_wallet;
  final String to_wallet_icon;
  final String? admin_wallet;
  final String? user_wallet_id;
  final String? user_op_code;
  final String? user_image;
  final String? user_full_name;
  final String? user_phone;
  final String? user_place;
  final String? user_email;
  final String? admin_op_code;
  final String? admin_image;
  final String? message;
  final int status;
  final DateTime created_at;
  final DateTime updated_at;

  TransactionModel({
    required this.id,
    required this.user_id,
    required this.send_amount,
    required this.receive_amount,
    required this.commission,
    required this.from_wallet,
    required this.from_wallet_icon,
    required this.to_wallet,
    required this.to_wallet_icon,
    required this.admin_wallet,
    this.user_wallet_id,
    this.user_op_code,
    this.user_image,
    this.user_full_name,
    this.user_phone,
    this.user_place,
    this.user_email,
    this.admin_op_code,
    this.admin_image,
    this.message,
    required this.status,
    required this.created_at,
    required this.updated_at,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': user_id,
      'send_amount': send_amount,
      'receive_amount': receive_amount,
      'commission': commission,
      'from_wallet': from_wallet,
      'from_wallet_icon': from_wallet_icon,
      'to_wallet': to_wallet,
      'to_wallet_icon': to_wallet_icon,
      'admin_wallet': admin_wallet,
      'user_wallet_id': user_wallet_id,
      'user_op_code': user_op_code,
      'user_image': user_image,
      'user_full_name': user_full_name,
      'user_phone': user_phone,
      'user_place': user_place,
      'user_email': user_email,
      'admin_op_code': admin_op_code,
      'admin_image': admin_image,
      'message': message,
      'status': status,
      'created_at': created_at.toString(),
      'updated_at': updated_at.toString(),
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as int,
      user_id: map['user_id'] as int,
      send_amount: double.parse('${map['send_amount']}'),
      receive_amount: double.parse('${map['receive_amount']}'),
      commission: double.parse('${map['commission']}'),
      from_wallet: map['from_wallet'] as String,
      from_wallet_icon: map['from_wallet_icon'] as String,
      to_wallet: map['to_wallet'] as String,
      to_wallet_icon: map['to_wallet_icon'] as String,
      admin_wallet:
          map['admin_wallet'] != null ? map['admin_wallet'] as String : null,
      user_wallet_id: map['user_wallet_id'] != null
          ? map['user_wallet_id'] as String
          : null,
      user_op_code:
          map['user_op_code'] != null ? map['user_op_code'] as String : null,
      user_image:
          map['user_image'] != null ? map['user_image'] as String : null,
      user_full_name: map['user_full_name'] != null
          ? map['user_full_name'] as String
          : null,
      user_phone:
          map['user_phone'] != null ? map['user_phone'] as String : null,
      user_place:
          map['user_place'] != null ? map['user_place'] as String : null,
      user_email:
          map['user_email'] != null ? map['user_email'] as String : null,
      admin_op_code:
          map['admin_op_code'] != null ? map['admin_op_code'] as String : null,
      admin_image:
          map['admin_image'] != null ? map['admin_image'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      status: map['status'] as int,
      created_at: DateFormat('yyyy-MM-dd hh:mm').parse(
          DateTime.parse(map['created_at'] as String).toLocal().toString()),
      // created_at: DateFormat("y-M-d HH:mm:ss")
      //     .parse((DateTime.parse(map['created_at'] as String)).toString()),
      updated_at: DateUtils.dateOnly(DateFormat("yyyy-MM-dd")
          .parse(DateTime.parse(map['updated_at'] as String).toString())),
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
