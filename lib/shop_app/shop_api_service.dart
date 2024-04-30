import 'package:dio/dio.dart';
import 'shop_home_model.dart';

class ShopApiService {
  final dio = Dio();
  List<ProductModel> products = [];
  List<BannerModel> banners = [];
  List<CategoryModel> categories = [];

   Future<List<ProductModel>> fetchProducts() async {
    final response = await dio.get('https://student.valuxapps.com/api/home');
    if (response.statusCode == 200) {
      for (var element in response.data['data']['products']) {
        final ProductModel homeModel = ProductModel.fromJson(element);
        products.add(homeModel);
      }
      return products;
    } else {
      return products;
      print('field');
    }
  }

  Future<List<BannerModel>> fetchBanners() async {
    final response = await dio.get('https://student.valuxapps.com/api/home');
    if (response.statusCode == 200) {
      for (var element in response.data['data']['banners']) {
        final BannerModel bannerModel = BannerModel.fromJson(element);
        banners.add(bannerModel);
      }
      return banners;
    } else {
      print('field');
      return banners;
    }
  }

  Future<List<CategoryModel>> fetchCategories() async {
    final response =
        await dio.get('https://student.valuxapps.com/api/categories');
    if (response.statusCode == 200) {
      for (var element in response.data['data']['data']) {
        final CategoryModel categoryModel = CategoryModel.fromJson(element);
        categories.add(categoryModel);
      }
      return categories;
    } else {
      return categories;
      print('field');
    }
  }
}
