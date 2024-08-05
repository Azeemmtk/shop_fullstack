class Productmodel {
  String? name;
  String? category;
  int? price;
  String? details;
  String? size;
  String? colour;
  String? image;
  String? sId;
  int? iV;

  Productmodel(
      {this.name,
      this.category,
      this.price,
      this.details,
      this.size,
      this.colour,
      this.image,
      this.sId,
      this.iV});

  Productmodel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    category = json['category'];
    price = json['price'];
    details = json['details'];
    size = json['size'];
    colour = json['colour'];
    image = json['image'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['category'] = this.category;
    data['price'] = this.price;
    data['details'] = this.details;
    data['size'] = this.size;
    data['colour'] = this.colour;
    data['image'] = this.image;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}
