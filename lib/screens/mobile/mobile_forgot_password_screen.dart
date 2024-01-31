// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:mealselection/resources/auth_methods.dart';
import 'package:mealselection/responsive/responsive_layout_screen.dart';
import 'package:mealselection/screens/mobile/mobile_login_screen.dart';
import 'package:mealselection/screens/web/web_login_screen.dart';
import 'package:mealselection/utils/colors.dart';
import 'package:mealselection/utils/utils.dart';
import 'package:mealselection/widgets/text_field_input.dart';

class MobileForgotPasswordScreen extends StatefulWidget {
  const MobileForgotPasswordScreen({super.key});

  @override
  State<MobileForgotPasswordScreen> createState() =>
      _MobileForgotPasswordScreenState();
}

class _MobileForgotPasswordScreenState
    extends State<MobileForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  void resetPassword() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().resetPassword(
      email: _emailController.text,
    );

    if (res == "success") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileLoginScreen(),
            webScreenLayout: WebLoginScreen(),
          ),
        ),
      );
      showSnackBar(
          "Password reset email sent to ${_emailController.text}.", context);
    } else {
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
              const Text(
                "We'll send a verification code to this email if it matches an existing Meal Selection account.",
                style: TextStyle(fontSize: 15),
              ),
              Flexible(flex: 1, child: Container()),
              //text field input for email
              TextFieldInput(
                hintText: 'Email',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),
              Flexible(flex: 1, child: Container()),
              // button login
              InkWell(
                onTap: resetPassword,
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
                          'Next',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ResponsiveLayout(
                      mobileScreenLayout: MobileLoginScreen(),
                      webScreenLayout: WebLoginScreen(),
                    ),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text(
                    "Go Back",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Flexible(flex: 7, child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
