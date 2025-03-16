import 'package:flutter/material.dart';
import 'offer_styles.dart';

class GiftOfferCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String giftDescription;
  final VoidCallback onTap;

  const GiftOfferCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.giftDescription,
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
          color: const Color(0xFFE91E63), // Pink
        ),
        child: Stack(
          children: [
            // Background gift pattern
            Positioned(
              right: -20,
              top: -20,
              child: Icon(
                Icons.card_giftcard,
                size: 120,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
            // Decorative ribbons
            Positioned(
              left: -20,
              bottom: -20,
              child: Transform.rotate(
                angle: 0.3,
                child: Icon(
                  Icons.celebration,
                  size: 100,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.card_giftcard,
                          color: Color(0xFFE91E63),
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'احصل على هدية مجانية',
                          style: OfferStyles.subtitleStyle.copyWith(
                            color: const Color(0xFFE91E63),
                            fontWeight: FontWeight.bold,
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
}
