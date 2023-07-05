// import 'package:expresso/pages/shipper/models/product_model.dart';

// class OrderModel {
//   final String instuctions;
//   final Map priceDetails;
//   final List<ProductModel> cart;
//   final String placedBy;

//   OrderModel(
//       {required this.placedBy,
//       required this.instuctions,
//       required this.priceDetails,
//       required this.cart});
// }

// ignore_for_file: unnecessary_new

class OrdersList {
  String? status;
  String? requestedAt;
  String? message;
  int? noOfOrders;
  List<Orders>? orders;

  OrdersList(
      {this.status,
      this.requestedAt,
      this.message,
      this.noOfOrders,
      this.orders});

  OrdersList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    requestedAt = json['requestedAt'];
    message = json['message'];
    noOfOrders = json['noOfOrders'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['requestedAt'] = this.requestedAt;
    data['message'] = this.message;
    data['noOfOrders'] = this.noOfOrders;
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  PriceDetails? priceDetails;
  Delivery? delivery;
  String? sId;
  String? placedBy;
  List<Cart>? cart;
  String? instructions;
  bool? isActive;
  bool? isAccepted;
  int? status;
  String? createdAt;
  int? iV;
  String? id;
  bool added = false;

  Orders({
    this.priceDetails,
    this.delivery,
    this.sId,
    this.placedBy,
    this.cart,
    this.instructions,
    this.isActive,
    this.isAccepted,
    this.status,
    this.createdAt,
    this.iV,
    this.id,
  });

  Orders.fromJson(Map<String, dynamic> json) {
    priceDetails = json['priceDetails'] != null
        ? new PriceDetails.fromJson(json['priceDetails'])
        : null;
    delivery = json['delivery'] != null
        ? new Delivery.fromJson(json['delivery'])
        : null;
    sId = json['_id'];
    placedBy = json['placedBy'];
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart!.add(new Cart.fromJson(v));
      });
    }
    instructions = json['instructions'];
    isActive = json['isActive'];
    isAccepted = json['isAccepted'];
    status = json['status'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.priceDetails != null) {
      data['priceDetails'] = this.priceDetails!.toJson();
    }
    if (this.delivery != null) {
      data['delivery'] = this.delivery!.toJson();
    }
    data['_id'] = this.sId;
    data['placedBy'] = this.placedBy;
    if (this.cart != null) {
      data['cart'] = this.cart!.map((v) => v.toJson()).toList();
    }
    data['instructions'] = this.instructions;
    data['isActive'] = this.isActive;
    data['isAccepted'] = this.isAccepted;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    data['id'] = this.id;
    return data;
  }
}

class PriceDetails {
  double? basePrice;
  int? discount;
  int? deliveryCharges;
  double? totalAmount;

  PriceDetails(
      {this.basePrice, this.discount, this.deliveryCharges, this.totalAmount});

  PriceDetails.fromJson(Map<String, dynamic> json) {
    basePrice = json['basePrice'];
    discount = json['discount'];
    deliveryCharges = json['deliveryCharges'];
    totalAmount = json['totalAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['basePrice'] = this.basePrice;
    data['discount'] = this.discount;
    data['deliveryCharges'] = this.deliveryCharges;
    data['totalAmount'] = this.totalAmount;
    return data;
  }
}

class Delivery {
  bool? isDelivered;

  Delivery({this.isDelivered});

  Delivery.fromJson(Map<String, dynamic> json) {
    isDelivered = json['isDelivered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isDelivered'] = this.isDelivered;
    return data;
  }
}

class Cart {
  String? productName;
  double? productPrice;
  String? sId;

  Cart({this.productName, this.productPrice, this.sId});

  Cart.fromJson(Map<String, dynamic> json) {
    productName = json['productName'];
    productPrice = json['productPrice'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productName'] = this.productName;
    data['productPrice'] = this.productPrice;
    data['_id'] = this.sId;
    return data;
  }
}
