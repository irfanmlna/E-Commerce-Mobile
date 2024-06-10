// ignore_for_file: prefer_const_constructors

import 'package:project_store/models/model_product.dart';
import 'package:project_store/screens/screen_detailproduct.dart';
import 'package:project_store/utils/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ListProduct extends StatefulWidget {
  const ListProduct({super.key});

  @override
  State<ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  TextEditingController txtcari = TextEditingController();
  bool isLoading = false;
  late List<Datum> _allProducts = [];
  late List<Datum> _searchResult = [];

  Future<List<Datum>?> getProduct() async {
    try {
      setState(() {
        isLoading = true;
      });
      http.Response res = await http.get(Uri.parse('$url/getlistproduct.php'));
      List<Datum> data = modelProductFromJson(res.body).data ?? [];
      setState(() {
        _allProducts = data;
        _searchResult = data;
      });
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('data belum ada')));
      });
    }
  }

  void _filterProduct(String query) {
    List<Datum> filteredBerita = _allProducts
        .where((product) =>
            product.productName!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      _searchResult = filteredBerita;
    });
  }

  @override
  void initState() {
    super.initState();
    getProduct(); // Memuat daftar produk saat widget pertama kali dibuat
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCEFE7),
      body: Column(
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
                color: Color(0xff5B4E3B),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    onChanged: _filterProduct,
                    controller: txtcari,
                    decoration: InputDecoration(
                      prefixIconColor: Color(0xff5B4E3B),
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Icon(Icons.search, size: 20),
                      ),
                      hintText: "Search",
                      hintStyle:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.brown.shade100,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text('All Products',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _searchResult.length,
                      itemBuilder: (context, index) {
                        Datum? data = _searchResult[index];

                        return ProductItem(
                          data: data,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Datum? data;

  final priceFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.');
  ProductItem({required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                DetailProduct(data),
          ),
        );
      },
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Image.network(
                '$url/image/${data!.productImage}',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data!.productName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      data!.productDesc,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      priceFormatter.format(double.parse(data!.productPrice)),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // Tambahkan logika untuk menambahkan ke keranjang
                },
                child: Text('Add',
                    style: TextStyle(
                      color: Colors.white,
                    )),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff5B4E3B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
