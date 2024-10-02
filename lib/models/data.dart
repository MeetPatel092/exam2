class DbModel {
  final int? id;
  final String name;

  DbModel({this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {
      'product_id': id,
      'product_name': name,
    };
  }

  factory DbModel.fromMap(Map<String, dynamic> map) {
    return DbModel(
      id: map['product_id'] as int?,
      name: map['product_name'] as String,
    );
  }
}
