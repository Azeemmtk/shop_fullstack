class FavouriteModel {
  String? userid;
  String? productid;
  String? sId;
  int? iV;

  FavouriteModel({this.userid, this.productid, this.sId, this.iV});

  FavouriteModel.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    productid = json['productid'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['productid'] = this.productid;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}
