class OrderDetail {
  List<Orders>? orders;

  OrderDetail({this.orders});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  int? orderId;
  String? date;
  String? status;
  String? totalPrice;
  int? totalLeft;
  List<ListItem>? listItem;

  Orders(
      {this.orderId,
      this.date,
      this.status,
      this.totalPrice,
      this.totalLeft,
      this.listItem});

  Orders.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    date = json['date'];
    status = json['status'];
    totalPrice = json['total_price'];
    totalLeft = json['total_left'];
    if (json['list_item'] != null) {
      listItem = <ListItem>[];
      json['list_item'].forEach((v) {
        listItem!.add(new ListItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['date'] = this.date;
    data['status'] = this.status;
    data['total_price'] = this.totalPrice;
    data['total_left'] = this.totalLeft;
    if (this.listItem != null) {
      data['list_item'] = this.listItem!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListItem {
  String? name;
  String? image;
  int? price;
  int? quantity;

  ListItem({this.name, this.image, this.price, this.quantity});

  ListItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    price = json['price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    return data;
  }
}