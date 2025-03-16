import 'package:flutter/material.dart';
import 'offer_styles.dart';

class DiscountOfferCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String discountPercentage;
  final VoidCallback onTap;

  const DiscountOfferCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.discountPercentage,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 160,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: OfferStyles.cardDecoration(
          color: const Color(0xFFE53935), // Deep Red
        ),
        child: Stack(
          children: [
            // Background pattern
            Positioned(
              right: -20,
              top: -20,
              child: Icon(
                Icons.local_offer,
                size: 120,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: OfferStyles.titleStyle,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        subtitle,
                        style: OfferStyles.subtitleStyle,
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'عرض لفترة محدودة',
                          style: OfferStyles.subtitleStyle.copyWith(
                            color: const Color(0xFFE53935),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  // Discount percentage
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.2),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '$discountPercentage%\nخصم',
                        textAlign: TextAlign.center,
                        style: OfferStyles.priceStyle,
                      ),
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
}
