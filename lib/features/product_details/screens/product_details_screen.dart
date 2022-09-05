import 'package:e_commerce/common/widgets/custom_button.dart';
import 'package:e_commerce/common/widgets/loader.dart';
import 'package:e_commerce/constants/global_variables.dart';
import 'package:e_commerce/constants/utils.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/services/cart_services.dart';
import 'package:e_commerce/features/home/widgets/rating_tag.dart';
import 'package:e_commerce/features/product_details/services/product_details_services.dart';
import 'package:e_commerce/features/product_details/widgets/comment_card.dart';
import 'package:e_commerce/features/product_details/widgets/rating_modal.dart';
import 'package:e_commerce/features/search/screens/search_screen.dart';
import 'package:e_commerce/providers/user_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = '/product-details';
  final String productId;
  const ProductDetailsScreen({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsServices productDetailsServices = ProductDetailsServices();
  final CartServices cartServices = CartServices();
  Product? product;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    fetchProductDetails(widget.productId);
  }

  void fetchProductDetails(String id) async {
    Product? fetchedProduct = await productDetailsServices.fetchProductDetails(context: context, productId: id);
    if (fetchedProduct != null) {
      product = fetchedProduct;
      setState(() {});
    }
  }

  void navigateToSearchScreen(String searchQuery) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: searchQuery);
  }

  void rateProduct() {
    showBottomDialogPopup(
      context: context,
      height: MediaQuery.of(context).size.height * .4,
      title: 'Review',
      item: RatingModal(
        onPostReview: (review, rating)async {
          productDetailsServices.rateProduct(
            comment: review,
            context: context,
            product: product!,
            rating: rating,
            date: DateFormat.yMd().format(DateTime.now()),
            userName: Provider.of<UserProvider>(context, listen: false).user.name,
          );
          fetchProductDetails(widget.productId);
          Navigator.pop(context);
        },
      ),
    );
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
      body: product == null
          ? const Loader()
          : ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                CarouselSlider(
                  items: product!.gallery.map(
                    (e) {
                      return Builder(
                        builder: (BuildContext context) => CachedNetworkImage(
                          imageUrl: e,
                          fit: BoxFit.contain,
                          height: 300,
                        ),
                      );
                    },
                  ).toList(),
                  options: CarouselOptions(
                    viewportFraction: 1,
                    height: 250,
                    autoPlay: (product!.gallery.length > 1),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                product!.name,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'poppins',
                                  color: Color(0xFF0A0E2F),
                                ),
                              ),
                            ),
                            RatingTag(
                              margin: const EdgeInsets.only(left: 10),
                              value: getAvgRating(product!.ratings),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        child: Text(
                          '\$${product!.price}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'poppins',
                            color: Color(0xFF0A0E2F),
                          ),
                        ),
                      ),
                      Text(
                        product!.description,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          height: 150 / 100,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Quantity',
                        style: TextStyle(
                          color: Color(0xFF0A0E2F),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'poppins',
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black12,
                                    width: 0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black12,
                                ),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (quantity > 1) {
                                          --quantity;
                                          setState(() {});
                                        }
                                      },
                                      child: Container(
                                        width: 35,
                                        height: 32,
                                        alignment: Alignment.center,
                                        child: const Icon(Icons.remove, size: 18),
                                      ),
                                    ),
                                    Container(
                                      width: 35,
                                      height: 32,
                                      color: Colors.white,
                                      alignment: Alignment.center,
                                      child: Text('$quantity'),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        ++quantity;
                                        setState(() {});
                                      },
                                      child: Container(
                                        width: 35,
                                        height: 32,
                                        alignment: Alignment.center,
                                        child: const Icon(Icons.add, size: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: rateProduct,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    onPrimary: const Color(0xFF0A0E2F),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    primary: const Color(0xFFEAEAF2),
                  ),
                  child: Row(
                    children: const [
                      Text(
                        'Rate this product',
                        style: TextStyle(
                          color: Color(0xFF0A0E2F),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(Icons.comment, size: 15)
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExpansionTile(
                        initiallyExpanded: true,
                        childrenPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                        tilePadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                        title: const Text(
                          'Reviews',
                          style: TextStyle(
                            color: Color(0xFF0A0E2F),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'poppins',
                          ),
                        ),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) =>
                                CommentCard(rating: product!.ratings[index]),
                            separatorBuilder: (context, index) => const SizedBox(height: 16),
                            itemCount: product!.ratings.length > 5 ? 5 : product!.ratings.length,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: kElevationToShadow[3],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomButton(
              height: 40,
              width: 150,
              text: 'Add to Cart',
              color: const Color.fromRGBO(254, 216, 19, 1),
              onTap: () {
                cartServices.modifyCart(
                  context: context,
                  product: product!,
                  quantity: quantity,
                  successMsg: 'Product added to the cart',
                );
              },
            ),
            const SizedBox(width: 5),
            CustomButton(
              height: 40,
              width: 150,
              text: 'Buy',
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
