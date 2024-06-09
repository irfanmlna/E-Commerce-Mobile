import 'package:flutter/material.dart';

class AboutUsWidget extends StatefulWidget {
  @override
  _AboutUsWidgetState createState() => _AboutUsWidgetState();
}

class _AboutUsWidgetState extends State<AboutUsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCEFE7),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Legal And Policies',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        backgroundColor: Color(0xFF5B4E3B), // Updated color here
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
              20.0), // Padding untuk memberikan ruang di sekitar konten
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Mulai dari kiri atas halaman
            children: <Widget>[
              Text(
                'Terms',
                style: TextStyle(
                  fontSize: 20, // Ukuran judul
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'By using our e-commerce app, you agree to the following terms. You must be at least 18 years old or have parental permission. You are responsible for your accounts confidentiality and activities. We strive for accurate product information but do not guarantee it. Prices and availability can change without notice. Purchases follow our payment policy, and returns and exchanges follow our return policy. Your personal information is used per our Privacy Policy. The app is provided "as is" without warranties, and we are not liable for any damages from using it. For questions or complaints, contact customer support through the app.',
                style: TextStyle(
                  fontSize: 14, // Ukuran subjudul
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Service',
                style: TextStyle(
                  fontSize: 20, // Ukuran judul
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'We offer various watches with detailed product information. Accepted payment methods include credit cards, bank transfers, and digital payments, processed in the specified currency. Shipping times and costs vary by location. Our return and exchange policy ensures your satisfaction. Customer support is available for assistance. We secure your personal information and transactions with encryption and security measures. Thank you for choosing our app for your watch needs.',
                style: TextStyle(
                  fontSize: 14, // Ukuran subjudul
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 500), // Spacer
            ],
          ),
        ),
      ),
    );
  }
}
