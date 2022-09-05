import 'package:e_commerce/common/widgets/loader.dart';
import 'package:e_commerce/constants/global_variables.dart';
import 'package:e_commerce/constants/utils.dart';
import 'package:e_commerce/features/product_details/screens/product_details_screen.dart';
import 'package:e_commerce/features/search/services/search_services.dart';
import 'package:e_commerce/features/search/widgets/filter_box.dart';
import 'package:e_commerce/features/search/widgets/filter_modal.dart';
import 'package:e_commerce/features/search/widgets/searched_product.dart';
import 'package:e_commerce/models/product.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final SearchServices searchServices = SearchServices();
  final TextEditingController searchController = TextEditingController();
  double maxPrice = 100000000.0;
  double minPrice = 0.0;
  bool hasDiscounts = false;
  bool searchByDiscount = false;

  @override
  void initState() {
    super.initState();
    fetchSearchedProducts();
    searchController.text = widget.searchQuery;
  }

  void fetchSearchedProducts() async {
    products = await searchServices.fetchSearchedProducts(
      context: context,
      searchQuery: widget.searchQuery,
      maxPrice: maxPrice,
      minPrice: minPrice,
      searchByDiscount: searchByDiscount,
      hasDiscounts: hasDiscounts,
    );
    setState(() {});
  }

  void navigateToSearchScreen(String searchQuery) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: searchQuery).then((value) => fetchSearchedProducts());
  }

  void navigateToProductDetailsScreen(Product product) {
    Navigator.pushNamed(context, ProductDetailsScreen.routeName, arguments: product.id)
        .then((value) => fetchSearchedProducts());
  }

  void filter() {
    showBottomDialogPopup(
        context: context,
        height: MediaQuery.of(context).size.height * .7,
        title: 'Filter',
        item: FilterModal(
          onApplyFilter: (double miniPrice, double maxiPrice, bool searchDiscount, bool discounts) {
            Navigator.pop(context);
            products = null;
            setState(() {});
            minPrice = miniPrice;
            maxPrice = maxiPrice;
            hasDiscounts = discounts;
            searchByDiscount = searchDiscount;
            fetchSearchedProducts();
          },
        ));
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
                      controller: searchController,
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
      body: products == null
          ? const Loader()
          : Column(
              children: [
                FilterBox(
                  onFilterButtonPressed: filter,
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: products!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () => navigateToProductDetailsScreen(products![index]),
                          child: SearchedProduct(product: products![index]));
                    },
                  ),
                )
              ],
            ),
    );
  }
}
