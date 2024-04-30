import 'package:flutter/material.dart';
import 'package:grade13/shop_app/shop_api_service.dart';

import 'shop_home_model.dart';

class ShopView extends StatefulWidget {
  const ShopView({Key? key}) : super(key: key);

  @override
  State<ShopView> createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> {
  final ShopApiService _apiService = ShopApiService();
  late Future<List<BannerModel>> futureBanners;
  late Future<List<ProductModel>> futureProducts;
  late Future<List<CategoryModel>> futureCategories;

  @override
  void initState() {
    futureBanners = _apiService.fetchBanners();
    futureCategories = _apiService.fetchCategories();
    futureProducts = _apiService.fetchProducts();
    super.initState();
  }

  int currentIndex = 0;
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shop app',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Icon(
            Icons.search,
            size: 35,
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (val) {
          setState(() {
            currentIndex = val;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favourite'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: FutureBuilder(
              future: futureBanners,
              builder: (context, snapshot) {
                final data = snapshot.data;
                return SizedBox(
                  height: 270,
                  child: ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final bannerImage = data?[index].imgUrl;
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(bannerImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          const SliverToBoxAdapter(
            child: Text(
              'Categories',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          SliverToBoxAdapter(
            child: FutureBuilder(
              future: futureCategories,
              builder: (context, snapshot) {
                final data = snapshot.data;
                return SizedBox(
                  height: 150,
                  child: ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final categoryImage = data?[index].imgUrl;
                      final categoryName = data?[index].name;
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 7),
                        width: 180,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(categoryImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: 180,
                          height: 40,
                          color: Colors.black.withOpacity(0.4),
                          alignment: Alignment.center,
                          child: Text(
                            categoryName!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          const SliverToBoxAdapter(
            child: Text(
              'Products',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            sliver: FutureBuilder(
              future: futureProducts,
              builder: (context, snapshot) {
                final data = snapshot.data;
                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    childAspectRatio: 0.75,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      final product = data?[index];
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.withOpacity(0.4),width: 2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Visibility(
                              visible: product?.discount != 0,
                              child: Container(
                                color: Colors.yellow,
                                child: Text(
                                  'Discount ${product?.discount ?? 0} %',
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: product?.imgUrl == null
                                    ? const CircularProgressIndicator()
                                    : Image.network(
                                  product!.imgUrl,
                                  width: 200,
                                  height: 200,
                                ),
                              ),
                            ),
                           // Spacer(),
                            Text(product?.productName ?? '',textAlign:TextAlign.end),
                            Row(
                              children: [
                                Text(
                                  '${(product?.price.toInt()) ?? 00}',
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '${product?.oldPrice.toInt() ?? 00}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isFav = !isFav;
                                    });
                                  },
                                  icon:  Icon(Icons.favorite, size: 20,color: isFav ? Colors.red : Colors.grey ,),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: snapshot.data?.length ?? 0,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
