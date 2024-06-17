class Orderr {
  Order? order;
  String? message;

  Orderr({this.order, this.message});

  Orderr.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Order {
  int? totalPrice;
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Order(
      {this.totalPrice, this.userId, this.updatedAt, this.createdAt, this.id});

  Order.fromJson(Map<String, dynamic> json) {
    totalPrice = json['total_price'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_price'] = this.totalPrice;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
