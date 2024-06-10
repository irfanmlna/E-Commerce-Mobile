// ignore_for_file: prefer_const_constructors

import 'package:project_store/main.dart';
import 'package:project_store/models/model_category.dart';
import 'package:project_store/screens/screen_cart.dart';
import 'package:project_store/screens/screen_detailcategory.dart';
import 'package:project_store/screens/screen_listproduct.dart';
import 'package:project_store/utils/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isLoading = false;
  String? id, username;
  late List<Datum> _allCat = [];
  Future<List<Datum>?> getProduct() async {
    try {
      setState(() {
        isLoading = true;
      });
      http.Response res = await http.get(Uri.parse('$url/getcategory.php'));
      List<Datum> data = modelCategoryFromJson(res.body).data ?? [];
      setState(() {
        _allCat = data;
      });
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  Future getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id") ?? '';
      username = pref.getString("username") ?? '';
      // print('id $id');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getSession();
    getProduct();
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
                  onPressed: () {},
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              PageHome(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Text(
                          'Home',
                          style: TextStyle(
                            color: Color(0xff5B4E3B),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Stack(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Category',
                          style:
                              TextStyle(color: Color(0xff5B4E3B), fontSize: 18),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 10, // Adjust this value to change the distance
                        child: Container(
                          color: Colors.brown,
                          height: 2,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _allCat.length,
                itemBuilder: (context, index) {
                  Datum? data = _allCat[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              DetailCategory(
                                  data.imagecat, data.categoryName, data.id),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                                child: Image.network(
                                  "$url/image/${data.imagecat}",
                                  fit: BoxFit.cover,
                                  height: 150,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.categoryName,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "${data.jumlah} products",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
