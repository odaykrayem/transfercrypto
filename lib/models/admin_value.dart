// ignore_for_file: public_member_api_docs, sort_constructors_first
class AdminValue {
  int id;
  String key;
  String value;

  AdminValue({
    required this.id,
    required this.value,
    required this.key,
  });

  factory AdminValue.fromMap(Map<String, dynamic> json) {
    return AdminValue(
      id: json['id'],
      key: json['key'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'key': key,
      'value': value,
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
