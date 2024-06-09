import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_store/screen_page/profile_screen.dart';

import 'package:project_store/utils/ip.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController txtPassword = TextEditingController();
  String? id;

  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  bool isLoading = false;
  Future getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id") ?? '';
    });
  }

  Future<void> updatePassword() async {
    try {
      setState(() {
        isLoading = true;
      });
      http.Response res =
          await http.post(Uri.parse('$ip/updatePassword.php'), body: {
        "id": '$id',
        "password": txtPassword.text,
      });
      if (res.statusCode == 200) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Password updated')));
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ProfileScreen()));
      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to update password')));
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
    super.initState();
    getSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCEFE7),
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Edit Password',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Color(0xFF5B4E3B),
      ),
      body: Center(
        child: Form(
          key: keyForm,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 16),
                TextFormField(
                  controller: txtPassword,
                  obscureText: true,
                  validator: (val) {
                    return val!.isEmpty ? "Password cannot be empty" : null;
                  },
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {
                    if (keyForm.currentState?.validate() == true) {
                      updatePassword();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill in the password"),
                        ),
                      );
                    }
                  },
                  color: Color(0xFF5B4E3B),
                  textColor: Colors.white,
                  height: 45,
                  child: const Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
