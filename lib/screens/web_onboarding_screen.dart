import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mealselection/responsive/mobile_home_screen.dart';
import 'package:mealselection/responsive/responsive_layout_screen.dart';
import 'package:mealselection/responsive/web_home_screen.dart';
import 'package:mealselection/utils/colors.dart';

class WebOnboardingScreen extends StatefulWidget {
  const WebOnboardingScreen({super.key});

  @override
  State<WebOnboardingScreen> createState() => _WebOnboardingScreenState();
}

class _WebOnboardingScreenState extends State<WebOnboardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const ResponsiveLayout(
          mobileScreenLayout: MobileHomeScreen(title: "Meal Selection"),
          webScreenLayout: WebHomeScreen(title: "Meal Selection"),
        ),
      ),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 100, 0, 0),
        child: Image.asset(
          'images/onboarding/$assetName',
          width: width,
        ));
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: mobileBackgroundColor,
      imagePadding: EdgeInsets.all(20),
      bodyAlignment: Alignment.bottomCenter,
    );

    return Scaffold(
      body: Row(
        children: [
          Flexible(child: Container()),
          SizedBox(
            width: 600,
            child: IntroductionScreen(
              key: introKey,
              globalBackgroundColor: mobileBackgroundColor,
              allowImplicitScrolling: true,
              pages: [
                PageViewModel(
                  title: "Select your meal time",
                  body:
                      "Choose which time you want the app to randomly select a meal for you.",
                  image: _buildImage('onboarding1.jpg'),
                  decoration: pageDecoration,
                ),
                PageViewModel(
                  title: "Add your favorite foods",
                  body: "Upload the foods that you enjoy one by one.",
                  image: _buildImage('onboarding2.jpg'),
                  decoration: pageDecoration,
                ),
                PageViewModel(
                  title: "Let the app choose for you",
                  body:
                      "Hit refresh and watch the app choose one of your favorite meals! ",
                  image: _buildImage('onboarding3.jpg'),
                  decoration: pageDecoration,
                ),
                PageViewModel(
                    title: "Start your day with a random choice",
                    body:
                        "The next time you want to eat, watch the app select one of the meals you enjoy!",
                    image: _buildImage('onboarding4.jpg'),
                    decoration: pageDecoration),
              ],
              onDone: () => _onIntroEnd(context),
              skipOrBackFlex: 0,
              nextFlex: 0,
              showBackButton: true,
              back: const Icon(Icons.arrow_back),
              next: const Icon(Icons.arrow_forward),
              done: const Text('Done',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              curve: Curves.fastLinearToSlowEaseIn,
              controlsMargin: const EdgeInsets.all(16),
              controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
              dotsDecorator: const DotsDecorator(
                size: Size(10.0, 10.0),
                color: Color(0xFFBDBDBD),
                activeSize: Size(22.0, 10.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
              dotsContainerDecorator: const ShapeDecoration(
                color: mobileBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
            ),
          ),
          Flexible(child: Container()),
        ],
      ),
    );
  }
}
