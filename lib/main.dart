// import 'package:project_store/api/firebase_api.dart';
import 'package:project_store/login.dart';
import 'package:project_store/screens/profile_screen.dart';
import 'package:project_store/screens/splash_screen.dart';
import 'package:project_store/screens/noti.dart';
import 'package:project_store/screens/screen_category.dart';
import 'package:project_store/screens/screen_home.dart';
import 'package:project_store/screens/screen_listfav.dart';
import 'package:project_store/screens/screen_paymentshistory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();
  // await FirebaseApi().initNotification();
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  // final AndroidInitializationSettings initializationSettingsAndroid =
  //     AndroidInitializationSettings('@mipmap/lc_launcher');
  // final InitializationSettings initializationSettings =
  //     InitializationSettings(android: initializationSettingsAndroid);
  // await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  Noti.init();
  runApp(const MyApp());

  // Noti.initialize(flutterLocalNotificationsPlugin);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        // visualDensity: VisualDensity.adaptivePlatformDensity,
        // fontFamily: 'Poppins',
        // textTheme: const TextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 22),
          backgroundColor: Color(0xff5B4E3B),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
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
          HomePage(),
          ListFavorite(),
          ListHistory(),
          ProfileScreen(),
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
