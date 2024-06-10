import 'package:project_store/screens/forgotpassword_screen.dart';
import 'package:project_store/utils/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// import 'package:project_store/screen_page/forgotpassword_screen.dart';
// import 'package:project_store/utils/ip.dart'; // Adjust the path to your IP file

class VerifyEmailRequest {
  final String email;

  VerifyEmailRequest({required this.email});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}

String baseUrl = '$url';

Future<int?> verifyEmail(String email) async {
  try {
    final url = Uri.parse(
        '$baseUrl/verifyEmail.php'); // Replace ip with your IP address
    final response = await http.post(
      url,
      body: jsonEncode(VerifyEmailRequest(email: email).toJson()),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['user_id'] != null) {
        return responseData['user_id'];
      } else {
        print('Error: User ID not found in response data');
        return null;
      }
    } else {
      print('Failed to verify email. Status code: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error verifying email: $e');
    return null;
  }
}

class VerifyEmail extends StatefulWidget {
  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final TextEditingController _emailController = TextEditingController();
  int? _userId;

  Future<void> _handleForgotPassword() async {
    final email = _emailController.text;
    final userId = await verifyEmail(email);
    setState(() {
      _userId = userId;
    });
    if (_userId != null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email verified. User ID: $_userId')),
      );
      // Navigate to ForgotPasswordScreen with the verified user ID
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ForgotPasswordScreen(userId: _userId)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email verification failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCEFE7),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 150),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Verify Your Email',
                    style: TextStyle(
                      color: Color(0xFF5B4E3B),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Enter your email to verify',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 40),
                Center(
                  child: SizedBox(
                    height: 49,
                    width: 283,
                    child: ElevatedButton(
                      onPressed: _handleForgotPassword,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 28.3, vertical: 4.9),
                        backgroundColor: Color(0xFF5B4E3B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        'Verify Email',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
