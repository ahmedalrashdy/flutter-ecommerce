import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/theme/extensions/theme_extensions.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  final _controller = Get.put(OnboardingController());

  OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            // Animated background color
            Obx(() => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  color: _controller.currentColor,
                  child: const SizedBox.expand(),
                )),
            SafeArea(
              child: Column(
                children: [
                  // Skip button
                  _buildSkipButton(),
                  // Page View
                  Expanded(
                    child: PageView.builder(
                      controller: _controller.pageController,
                      onPageChanged: _controller.selectedPageIndex,
                      itemCount: _controller.onboardingPages.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Image with animation
                              Hero(
                                tag: 'onboarding_$index',
                                child: Image.asset(
                                  _controller.onboardingPages[index].image,
                                  height: Get.height * 0.4,
                                ),
                              ),
                              const SizedBox(height: 40),
                              // Title
                              Text(
                                _controller.onboardingPages[index].title,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              // Description
                              Text(
                                _controller.onboardingPages[index].description,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  // Bottom navigation
                  Container(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Page indicators
                        Row(
                          children: List.generate(
                            _controller.onboardingPages.length,
                            (index) => Obx(
                              () => AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: const EdgeInsets.only(left: 5),
                                height: 10,
                                width:
                                    _controller.selectedPageIndex.value == index
                                        ? 25
                                        : 10,
                                decoration: BoxDecoration(
                                  color: _controller.selectedPageIndex.value ==
                                          index
                                      ? context.colors.primary
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Next/Get Started button
                        Obx(
                          () => ElevatedButton(
                            onPressed: _controller.nextPage,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: context.colors.primary,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 2,
                            ),
                            child: Text(
                              _controller.isLastPage ? 'ابدأ الآن' : 'التالي',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Align _buildSkipButton() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextButton(
          onPressed: _controller.skipToHome,
          child: Text(
            'تخطي',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
