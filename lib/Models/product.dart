class ProductModel {
  String? id;
  String? dressTitle;
  String? productDescription;
  double? price;
  List<String>? images;

  ProductModel({
    this.id,
    this.dressTitle,
    this.productDescription,
    this.price,
    this.images,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map, String id) {
    return ProductModel(
      id: id,
      dressTitle: map['dressTitle'],
      productDescription: map['productDescription'],
      price: map['price']?.toDouble(),
      images: List<String>.from(map['images'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dressTitle': dressTitle,
      'productDescription': productDescription,
      'price': price,
      'images': images,
    };
  }
}
