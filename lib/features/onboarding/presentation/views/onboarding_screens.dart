import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../config/constants/image_strings.dart';
import '../../../../config/constants/text_strings.dart';
import '../../../../config/router/app_routes.dart';
import 'widgets/onboarding_indicators.dart';
import 'widgets/onboarding_next_button.dart';
import 'widgets/onboarding_page_widgets.dart';
import 'widgets/onboarding_skip.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(
      const Duration(seconds: 10),
      (timer) {
        if (_currentPageIndex < 2) {
          _currentPageIndex++;
        } else {
          _currentPageIndex = 0;
        }
        _pageController.animateToPage(
          _currentPageIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  void _skipOnboarding() {
    //Navigator.pushReplacementNamed(context, MyRoutes.loginRoute);
    Navigator.pushReplacementNamed(context, MyRoutes.preloginRoute);
  }

  void _nextPage() {
    if (_currentPageIndex < 3) {
      _currentPageIndex++;
      _pageController.animateToPage(
        _currentPageIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _skipOnboarding();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildPageView(),
          OnBoardingSkip(onSkip: _skipOnboarding),
          OnBoardingDots(
            controller: _pageController,
            pageCount: 3,
          ),
          OnBoardingNextButton(onNext: _nextPage),
        ],
      ),
    );
  }

  Widget _buildPageView() {
    return PageView(
      controller: _pageController,
      onPageChanged: _updatePageIndex,
      children: const [
        OnBoardingPage(
          image: AppImages.onBoardingImage1,
          title: AppTexts.onBoardingTitle1,
          subTtile: AppTexts.onBoardingSubTitle1,
        ),
        OnBoardingPage(
          image: AppImages.onBoardingImage2,
          title: AppTexts.onBoardingTitle2,
          subTtile: AppTexts.onBoardingSubTitle2,
        ),
        OnBoardingPage(
          image: AppImages.onBoardingImage3,
          title: AppTexts.onBoardingTitle3,
          subTtile: AppTexts.onBoardingSubTitle3,
        ),
      ],
    );
  }

  void _updatePageIndex(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }
}
