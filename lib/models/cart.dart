import 'package:doge_coffee/models/menu.dart';

class Cart {
  int? id;
  int? userId;
  int? productId;
  int? count;
  String? note;
  String? createdAt;
  String? updatedAt;
  Menu menu;

  Cart(
      {this.id,
      this.userId,
      this.productId,
      this.count,
      this.note,
      this.createdAt,
      this.updatedAt,
      required this.menu});

  Cart.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        productId = json['product_id'],
        count = json['count'],
        note = json['note'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        menu = Menu.fromJson(json['menu']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['count'] = this.count;
    data['note'] = this.note;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['menu'] = this.menu.toJson();
    return data;
  }
}
