import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class TransferMethodValueModel {
  final int id;
  final String transfer_wallet_name;
  final String transfer_wallet_icon;
  final String receive_wallet_name;
  final String receive_wallet_icon;
  final double min_value;
  final double max_value;
  final double commission;
  final String admin_wallet_name;
  final String admin_wallet_code;

  TransferMethodValueModel({
    required this.id,
    required this.transfer_wallet_name,
    required this.transfer_wallet_icon,
    required this.receive_wallet_name,
    required this.receive_wallet_icon,
    required this.min_value,
    required this.max_value,
    required this.commission,
    required this.admin_wallet_name,
    required this.admin_wallet_code,
  });

  @override
  String toString() {
    return toMap().toString();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'transfer_wallet_name': transfer_wallet_name,
      'transfer_wallet_icon': transfer_wallet_icon,
      'receive_wallet_name': receive_wallet_name,
      'receive_wallet_icon': receive_wallet_icon,
      'min_value': min_value,
      'max_value': max_value,
      'commission': commission,
      'admin_wallet_name': admin_wallet_name,
      'admin_wallet_code': admin_wallet_code,
    };
  }

  factory TransferMethodValueModel.fromMap(Map<String, dynamic> map) {
    return TransferMethodValueModel(
      id: map['id'] as int,
      transfer_wallet_name: map['transfer_wallet_name'] as String,
      transfer_wallet_icon: map['transfer_wallet_icon'] as String,
      receive_wallet_name: map['receive_wallet_name'] as String,
      receive_wallet_icon: map['receive_wallet_icon'] as String,
      // min_value: map['min_value'] as double,
      // max_value: map['max_value'] as double,
      // commission: map['commission'] as double,

      min_value: double.parse('${map['min_value']}'),
      max_value: double.parse('${map['max_value']}'),
      commission: double.parse('${map['commission']}'),
      admin_wallet_name: map['admin_wallet_name'] as String,
      admin_wallet_code: map['admin_wallet_code'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransferMethodValueModel.fromJson(String source) =>
      TransferMethodValueModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
