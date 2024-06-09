import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_store/model/model_forget.dart';
import 'package:project_store/screen_page/login_screen.dart';
import 'package:project_store/utils/ip.dart'; // Replace with the correct path

class ForgotPasswordScreen extends StatefulWidget {
  final int? userId;

  ForgotPasswordScreen({required this.userId});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  String _message = '';
  bool isLoading = false;

  Future<void> changePassword(String newPassword) async {
    final changePasswordUrl = '$ip/resetPassword.php'; // Replace with your API URL

    final changePasswordResponse = await http.post(
      Uri.parse(changePasswordUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'user_id': widget.userId, 'new_password': newPassword}),
    );

    if (changePasswordResponse.statusCode == 200) {
      final changePasswordData = jsonDecode(changePasswordResponse.body);
      setState(() {
        _message = changePasswordData['message'];
      });
    } else {
      setState(() {
        _message = 'Failed to change password: ${changePasswordResponse.body}';
      });
    }
  }

  Future<ModelForgotPass?> registerAccount() async {
    try {
      setState(() {
        isLoading = true;
      });
      http.Response res = await http.post(
        Uri.parse('$ip/resetPassword.php'),
        body: {
          "id": widget.userId.toString(),
          "password": _newPasswordController.text,
        },
      );
      ModelForgotPass data = modelForgotPassFromJson(res.body);
      if (data.value == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else if (data.value == 2) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  @override
  void initState() {
    print(widget.userId);
    super.initState();
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
                    'Change Password',
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
                    'Reset Your Password',
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
                    'Enter your new password',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _newPasswordController,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 40),
                Center(
                  child: SizedBox(
                    height: 49,
                    width: 283,
                    child: ElevatedButton(
                      onPressed: () {
                        registerAccount();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 28.3, vertical: 4.9),
                        backgroundColor: Color(0xFF5B4E3B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        'Change Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    _message,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
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
