import 'package:project_store/screens/screen_cart.dart';
import 'package:project_store/screens/screen_category.dart';
import 'package:project_store/screens/screen_listfav.dart';
import 'package:project_store/screens/screen_paymentshistory.dart';
import 'package:flutter/material.dart';

class PageHomecat extends StatefulWidget {
  const PageHomecat({Key? key}) : super(key: key);

  @override
  State<PageHomecat> createState() => _PageHomecatState();
}

class _PageHomecatState extends State<PageHomecat>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      setState(() {
        _selectedIndex = tabController.index;
      });
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    tabController.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: tabController,
        children: const [
          CategoryPage(),
          ListFavorite(),
          ListHistory(),
          // Galery(),
          // PageListSejarah(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xff5B4E3B),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(0, Icons.home),
            _buildNavItem(1, Icons.favorite),
            _buildNavItem(2, Icons.attach_money),
            _buildNavItem(3, Icons.person),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        _onItemTapped(index);
      },
      child: Container(
        decoration: isSelected
            ? BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(10),
              )
            : null,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.grey,
        ),
      ),
    );
  }
}
