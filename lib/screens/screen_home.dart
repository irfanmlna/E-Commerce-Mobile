// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:project_store/main.dart';
import 'package:project_store/models/model_add.dart';
import 'package:project_store/models/model_product.dart';
import 'package:project_store/nav/bnav.dart';
import 'package:project_store/screens/screen_cart.dart';
import 'package:project_store/screens/screen_detailproduct.dart';
import 'package:project_store/screens/screen_listproduct.dart';
import 'package:project_store/screens/screen_tracking.dart';
import 'package:project_store/utils/url.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  String? id, username;
  String? serverMessage;

  final priceFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.');
  Future getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id") ?? '';
      username = pref.getString("username") ?? '';
      print('id $id');
    });
  }

  final List<String> imageList2 = [
    'assets/images/banner1.png',
  ];
  late List<Datum> _allProducts = [];
  Future<List<Datum>?> getProduct() async {
    try {
      setState(() {
        isLoading = true;
      });
      http.Response res = await http.get(Uri.parse('$url/getlistproduct.php'));
      List<Datum> data = modelProductFromJson(res.body).data ?? [];
      setState(() {
        _allProducts = data;
      });
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('data belum ada')));
      });
    }
  }

  Future<ModelAddjms?> addfav(String? idp, String? idu) async {
    try {
      setState(() {
        isLoading = true;
      });

      http.Response res = await http.post(Uri.parse('$url/addfav.php'), body: {
        "id_product": idp,
        "id_user": idu,
      });
      ModelAddjms data = modelAddjmsFromJson(res.body);
      //cek kondisi (ini berdasarkan value respon api
      //value 2 (email sudah terdaftar),1 (berhasil),dan 0 (gagal)
      if (data.isSuccess == true) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
          //pindah ke page login
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const PageHome()),
              (route) => false);
        });
      } else if (data.isSuccess == false) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
          setState(() {
            serverMessage = data.message;
          });
        });
      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
          setState(() {
            serverMessage = data.message;
          });
        });
      }
    } catch (e) {
      //munculkan error
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getProduct();
    getSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCEFE7),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30.0),
          ),
          child: AppBar(
            backgroundColor: Color(0xff5B4E3B),
            leading: Padding(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/unnamed.png'),
              ),
            ),
            title: Text(
              'Hi, $username\nLet\'s Go Shopping',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ListProduct()));
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 35,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShoppingCart()));
                  },
                  icon: Icon(
                    Icons.trolley,
                    color: Colors.black,
                    size: 35,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => TrackingPage()));
                  },
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.black,
                    size: 35,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Stack(
                      children: [
                        Text(
                          'Home',
                          style: TextStyle(
                            color: Color(0xff5B4E3B),
                            fontSize: 18,
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom:
                              -1, // Adjust this value to change the distance
                          child: Container(
                            color: Colors.brown,
                            height: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              PageHomecat(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                    child: Text(
                      'Category',
                      style: TextStyle(color: Color(0xff5B4E3B), fontSize: 18),
                    ),
                  )
                ],
              ),
              CarouselSlider(
                items: imageList2.map((item) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Color(0xffFCEFE7),
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage(item),
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 250.0,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'New Arrivals 🔥',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff5B4E3B),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                ListProduct(),
                          ),
                        );
                      },
                      child: Text(
                        'See All',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff5B4E3B),
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _allProducts.take(4).length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.7, // Adjust the aspect ratio as needed
                ),
                itemBuilder: (context, index) {
                  Datum? data = _allProducts[index];
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
                    child: Stack(
                      children: <Widget>[
                        GridTile(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(20.0),
                                  top: Radius.circular(20.0),
                                ),
                                child: Image.network(
                                  '$url/image/${data?.productImage}',
                                  height: 134,
                                  width: 130,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                '${data?.productName}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8),
                              Flexible(
                                child: Text(
                                  '${data?.productDesc}',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                priceFormatter
                                    .format(double.parse(data.productPrice)),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 22),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 8.0,
                          right: 8.0,
                          child: IconButton(
                            icon: Icon(Icons.favorite_border),
                            onPressed: () {
                              addfav(data.id, id);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
