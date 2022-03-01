import 'dart:convert';

import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'main_home.dart';

String? city;

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  bool isLogIn = false;

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: 'Meet with a flutter expert to learn together.',
          body:
              'It is here where our flutter journey starts.#Flutter provides us with a platform where we can share ideas together.',
          image: SvgPicture.asset(
            'assets/me.svg',
            height: 150,
            width: 130,
          ),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title:
              'Meet with other flutter developers, collaborate and share your ideas with a team.',
          body:
              'Seamless collaborating with others is at the core.',
          image: SvgPicture.asset(
            'assets/people.svg',
            height: 170,
          ),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: 'Grow fast.Grow together.',
          body:
              'A long journey starts with a single step. Together we can make changes with the power of flutter.',
          image: SvgPicture.asset(
            'assets/points.svg',
            height: 170,
          ),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: 'More apps, only for you.',
          body:
              'More apps reserved only for you.Useful for your daily activities.',
          image: SvgPicture.asset(
            'assets/website.svg',
            height: 150,
          ),
          decoration: getPageDecoration(),
        ),
      ],
      done: const Text('Go to Alchemist',
          style: TextStyle(fontWeight: FontWeight.w600)),
      onDone: () => goToHome(context),
      showSkipButton: true,
      skip: const Text('Skip'),
      onSkip: () => goToHome(context),
      next: const Icon(Icons.arrow_forward),
      dotsDecorator: getDotDecoration(),

      globalBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      nextFlex: 0,
      // showBackButton: true,
      
      // nextFlex: 0,
      // isProgressTap: false,
      // isProgress: false,
      // showNextButton: false,
      // freeze: true,
      // animationDuration: 1000,
    );
  }

  void goToHome(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => MainHome()),
    );
  }

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: const Color(0xFFBDBDBD),
        //activeColor: Colors.orange,
        size: const Size(10, 10),
        activeSize: const Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: const TextStyle(
            fontSize: 17, fontWeight: FontWeight.bold, height: 1.3),
        bodyTextStyle: const TextStyle(fontSize: 14, height: 1.4),
        // descriptionPadding: const EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: const EdgeInsets.all(24),
        pageColor: Colors.white,
      );
}
















