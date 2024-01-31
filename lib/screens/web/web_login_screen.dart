// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:mealselection/resources/auth_methods.dart';
import 'package:mealselection/screens/mobile/mobile_home_screen.dart';
import 'package:mealselection/responsive/responsive_layout_screen.dart';
import 'package:mealselection/screens/web/web_home_screen.dart';
import 'package:mealselection/screens/mobile/mobile_forgot_password_screen.dart';
import 'package:mealselection/screens/mobile/mobile_signup_screen.dart';
import 'package:mealselection/screens/web/web_forgot_password_screen.dart';
import 'package:mealselection/screens/web/web_signup_screen.dart';
import 'package:mealselection/utils/colors.dart';
import 'package:mealselection/utils/utils.dart';
import 'package:mealselection/widgets/text_field_input.dart';

class WebLoginScreen extends StatefulWidget {
  const WebLoginScreen({super.key});

  @override
  State<WebLoginScreen> createState() => _WebLoginScreenState();
}

class _WebLoginScreenState extends State<WebLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void logInUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (res == "success") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileHomeScreen(title: "Meal Selection"),
            webScreenLayout: WebHomeScreen(title: "Meal Selection"),
          ),
        ),
      );
      //
    } else {
      //
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Flexible(child: Container()),
            SizedBox(
              width: 600,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(flex: 5, child: Container()),
                    // Image
                    Image.asset(
                      'images/icons/web.png',
                      height: 150,
                    ),
                    Flexible(flex: 5, child: Container()),
                    //text field input for email
                    TextFieldInput(
                      hintText: 'Enter your email',
                      textInputType: TextInputType.emailAddress,
                      textEditingController: _emailController,
                    ),
                    Flexible(flex: 1, child: Container()),
                    // text field input for password
                    TextFieldInput(
                      hintText: 'Enter your password',
                      textInputType: TextInputType.text,
                      textEditingController: _passwordController,
                      isPass: true,
                    ),
                    Flexible(flex: 1, child: Container()),
                    // button login
                    InkWell(
                      onTap: logInUser,
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          color: blueColor,
                        ),
                        child: _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: primaryColor,
                                ),
                              )
                            : const Text(
                                'Log In',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                      ),
                    ),
                    Flexible(flex: 1, child: Container()),
                    // Transitioning to forgot password
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ResponsiveLayout(
                            mobileScreenLayout: MobileForgotPasswordScreen(),
                            webScreenLayout: WebForgotPasswordScreen(),
                          ),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: blueColor,
                          ),
                        ),
                      ),
                    ),
                    // Transitioning to signing up
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text("Don't have an account?"),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ResponsiveLayout(
                            mobileScreenLayout: MobileSignUpScreen(),
                            webScreenLayout: WebSignUpScreen(),
                          ),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Flexible(flex: 2, child: Container()),
                  ],
                ),
              ),
            ),
            Flexible(child: Container()),
          ],
        ),
      ),
    );
  }
}
