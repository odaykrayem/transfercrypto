import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class MethodModel {
  final String wallet_name;
  final String wallet_icon;

  MethodModel({
    required this.wallet_name,
    required this.wallet_icon,
  });

  @override
  String toString() {
    return toMap().toString();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'wallet_name': wallet_name,
      'wallet_icon': wallet_icon,
    };
  }

  factory MethodModel.fromMap(Map<String, dynamic> map) {
    return MethodModel(
      wallet_name: map['wallet_name'] as String,
      wallet_icon: map['wallet_icon'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MethodModel.fromJson(String source) =>
      MethodModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
