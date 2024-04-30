class ProductModel {
  final String productName;
  final String imgUrl;
  final num price;
  final num oldPrice;
  final num discount;

  ProductModel(
      {required this.productName,
      required this.imgUrl,
      required this.price,
      required this.discount,
      required this.oldPrice,
      });

  factory ProductModel.fromJson(Map<String, dynamic> data) {
    return ProductModel(
      oldPrice: data['old_price'],
      productName: data['name'],
      imgUrl: data['image'],
      price: data['price'],
      discount: data['discount'],
    );
  }
}

class CategoryModel {
  final String name;
  final String imgUrl;

  factory CategoryModel.fromJson(Map<String, dynamic> data) {
    return CategoryModel(name: data['name'], imgUrl: data['image']);
  }

  CategoryModel({required this.name, required this.imgUrl});
}

class BannerModel {
  final String imgUrl;
  final int id;

  factory BannerModel.fromJson(Map<String, dynamic> data) {
    return BannerModel(imgUrl: data['image'], id: data['id']);
  }

  BannerModel({required this.imgUrl, required this.id});
}
