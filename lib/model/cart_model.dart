import 'package:store/model/product_model.dart';

class CartModel {
  String? sId;
  String? userid;
  Productmodel? productid;
  String? status;
  int? quantity;
  int? iV;

  CartModel(
      {this.sId,
      this.userid,
      this.productid,
      this.status,
      this.quantity,
      this.iV});

  CartModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userid = json['userid'];
    status = json['status'];
    productid = json['productid'] != null
        ? new Productmodel.fromJson(json['productid'])
        : null;
    quantity = json['quantity'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userid'] = this.userid;
    data['status'] = this.status;
    if (this.productid != null) {
      data['productid'] = this.productid!.toJson();
    }
    data['quantity'] = this.quantity;
    data['__v'] = this.iV;
    return data;
  }
}
