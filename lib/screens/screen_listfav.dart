// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:project_store/models/model_product.dart';
import 'package:project_store/screens/screen_detailproduct.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_store/utils/url.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListFavorite extends StatefulWidget {
  const ListFavorite({super.key});

  @override
  State<ListFavorite> createState() => _ListFavoriteState();
}

class _ListFavoriteState extends State<ListFavorite> {
  bool isLoading = false;
  final priceFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.');
  String? id, username;
  Future getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id") ?? '';
      username = pref.getString("username") ?? '';
      // print('id $id');
    });
  }

  late List<Datum> _allCart = [];
  Future<List<Datum>?> getCart() async {
    try {
      setState(() {
        isLoading = true;
      });
      http.Response res =
          await http.post(Uri.parse('$url/getfavorite.php'), body: {
        "id_user": id,
      });
      List<Datum> data = modelProductFromJson(res.body).data ?? [];
      setState(() {
        _allCart = data;
      });
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Anda belum like apapun')));
      });
    }
  }

  String baseUrl = '$url';
  Future<void> deleteData(String id) async {
    // Replace with your actual API endpoint
    final url = Uri.parse('$baseUrl/deletefav.php');

    // Prepare the POST body with the ID
    final Map<String, String> data = {'id': id};

    try {
      final response = await http.post(url, body: data);

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        if (decodedResponse['status'] == 'success') {
          print('Data deleted successfully!');
        } else {
          print('Failed to delete data: ${decodedResponse['message']}');
        }
      } else {
        // Handle unsuccessful responses (e.g., network errors, server errors)
        print('Error deleting data: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exceptions (e.g., network connection issues)
      print('Error deleting data: $error');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getSession().then((_) => {getCart()});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCEFE7),
      appBar: AppBar(
        title: Text('List Favorite'),
        backgroundColor: Color(0xff5B4E3B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'List Favorite',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _allCart.length,
              itemBuilder: (context, index) {
                Datum? data = _allCart[index];
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
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () async {
                                final idToDelete =
                                    '${data.id}'; // Replace with the ID to delete
                                await deleteData(idToDelete);
                                getCart();
                              },
                              icon: Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )),
                          Image.network(
                            '$url/image/${data!.productImage}',
                            width: 70,
                            height: 70,
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
                                  priceFormatter
                                      .format(double.parse(data!.productPrice)),
                                  style: TextStyle(
                                    fontSize: 16,
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
                                style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff5B4E3B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ]),
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
                        fontSize: 16,
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
                child: Text('Add'),
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
