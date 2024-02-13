// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_commerce_app/common/widgets/loader.dart';
import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:e_commerce_app/features/home/widgets/address_box.dart';
import 'package:e_commerce_app/features/product_details/screens/product_details_screen.dart';
import 'package:e_commerce_app/features/search/services/search_services.dart';
import 'package:e_commerce_app/features/search/widgets/searched_product.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({
    Key? key,
    required this.searchQuery,
  }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? productList;
  SearchServices searchServices = SearchServices();
  @override
  void initState() {
    super.initState();
    fetchSearchedProducts();
  }

  fetchSearchedProducts() async {
    productList = await searchServices.fetchSearchedProducts(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    Navigator.of(context).pushNamed(SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return productList == null
        ? const Loader()
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60),
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
                            decoration: InputDecoration(
                              hintText: 'Search....',
                              hintStyle: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                              prefixIcon: InkWell(
                                onTap: () {},
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                    left: 6,
                                  ),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                    size: 23,
                                  ),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.only(top: 10),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.black38,
                                  width: 1,
                                ),
                              ),
                            ),
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
                        color: Colors.black,
                        size: 25,
                      ),
                    )
                  ],
                ),
              ),
            ),
            body: Column(
              children: [
                const AddressBox(),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: productList!.length,
                    itemBuilder: (context, index) {
                      var product = productList![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              ProductDetailsScreen.routeName,
                              arguments: product);
                        },
                        child: SearchedProduct(
                          product: product,
                        ),
                      );
                    },
                  ),
                )
              ],
            ));
  }
}
