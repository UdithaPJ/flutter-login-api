import 'package:flutter/material.dart';
import 'package:app_intern/SQLite/database_services.dart';
import 'package:app_intern/components/colors.dart';
import 'package:app_intern/components/login_button.dart';
import 'package:app_intern/components/textfield.dart';
import 'package:app_intern/pages/home.dart';
import '../models/users.dart';
import '../services/login_api_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isChecked = false;
  bool _isInvalidUser = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _userLogin(String username, String password) async {
    final loginApiService = LoginApiService();
    final databaseServices = DatabaseServices();

    try {
      // Using API call to validate the user
      Users? user = await loginApiService.login(username, password);
      if (user != null) {
        await databaseServices.storeUserData(user);

        setState(() {
          _isInvalidUser = false;
        });

        // Navigate to HomePage when login is successful
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        setState(() {
          _isInvalidUser = true;
        });
      }
    } catch (e) {
      debugPrint('Login error: $e');
      setState(() {
        _isInvalidUser = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: primaryColor.withOpacity(0.5),
                  ),
                ),
                Text(
                  'Please login to continue accessing your account',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.withOpacity(0.9),
                  ),
                ),
                Image.asset(
                  'assets/login-image.png',
                  width: size.width * 0.6,
                  height: size.width * 0.9,
                ),
                InputField(
                  hintText: 'Username',
                  icon: Icons.account_circle,
                  controller: _usernameController,
                  incorrect: _isInvalidUser
                ),
                InputField(
                  hintText: 'Password',
                  icon: Icons.lock,
                  controller: _passwordController,
                  textInvisible: true,
                  incorrect: _isInvalidUser
                ),
                ListTile(
                  horizontalTitleGap: 2,
                  title: const Text('Remember me'),
                  leading: Checkbox(
                    activeColor: primaryColor,
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value ?? false;
                      });
                    },
                  ),
                ),
                LoginButton(
                  label: 'Login',
                  onPressed: () async {
                    final username = _usernameController.text.trim();
                    final password = _passwordController.text.trim();

                    // Input validation
                    if (username.isNotEmpty && password.isNotEmpty) {
                      await _userLogin(username, password);
                    } else {
                      setState(() {
                        _isInvalidUser = true;
                      });
                    }
                  },
                ),
                if (_isInvalidUser)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Username or password is incorrect',
                      style: TextStyle(color: Colors.red.shade700),
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
