import 'dart:async';

import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final PageController _pageController = PageController();
  final List<String> imagePaths = [
    'assets/images/london_background_image.jpg',
    'assets/images/warsaw_background_image.jpg',
    'assets/images/tokyo_background_image.jpg'
  ];
  late Timer timer;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    // Start the timer to change the page every 3 seconds
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (currentPage < imagePaths.length - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      _pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: imagePaths.length,
      onPageChanged: (index) {
        setState(() {
          currentPage = index;
        });
      },
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            double value = 1.0;
            if (_pageController.position.haveDimensions) {
              value = _pageController.page! - index;
              value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
            }
            return Center(
              child: SizedBox(
                height: 400.0,
                width: 400.0,
                child: child,
              ),
            );
          },
          child: CircleAvatar(
            radius: 128.0,
            backgroundColor: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(128.0),
              child: Image.asset(
                imagePaths[index],
                fit: BoxFit.cover,
                height: 400.0,
                width: 400.0,
              ),
            ),
          ),
        );
      },
    );
  }
}
