import 'package:e_commerce/constants/global_variables.dart';
import 'package:e_commerce/features/home/screens/see_all_products_screen.dart';
import 'package:e_commerce/features/home/services/home_services.dart';
import 'package:e_commerce/features/home/widgets/address_box.dart';
import 'package:e_commerce/features/home/widgets/carousel_images.dart';
import 'package:e_commerce/features/home/widgets/more_products.dart';
import 'package:e_commerce/features/home/widgets/specials.dart';
import 'package:e_commerce/features/home/widgets/top_categories.dart';
import 'package:e_commerce/features/search/screens/search_screen.dart';
import 'package:e_commerce/models/product.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home-screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeServices homeServices = HomeServices();
  List<Product> discountedProducts = [];
  List<Product> moreProducts = [];

  @override
  void initState() {
    super.initState();
    fetchDiscountedProducts();
    fetchMoreProducts();
  }

  void fetchDiscountedProducts() async {
    discountedProducts =
        await homeServices.fetchDiscountedProducts(context: context, isForHomeDisplay: true);
    setState(() {});
  }

  void fetchMoreProducts() async {
    moreProducts = await homeServices.fetchMoreProducts(context: context);
    setState(() {});
  }

  void navigateToSearchScreen(String searchQuery) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: searchQuery).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: const InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.only(top: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            borderSide: BorderSide(color: Colors.black38, width: 1),
                          ),
                          hintText: 'Search e-conm',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          )),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(
                  Icons.mic,
                  size: 25,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AddressBox(),
            const SizedBox(height: 10),
            const TopCategories(),
            const SizedBox(height: 10),
            const CarouselImage(),
            if (discountedProducts.isNotEmpty)
              Specials(
                products: discountedProducts,
                title: 'Discounts',
                onSeeAll: () {
                  Navigator.pushNamed(context, SeeAllProductsScreen.routeName);
                },
              ),
            MoreProducts(products: moreProducts, title: "More")
          ],
        ),
      ),
    );
  }
}
