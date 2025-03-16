import 'package:flutter/material.dart';
import 'offer_styles.dart';

class ShippingOfferCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ShippingOfferCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: OfferStyles.cardDecoration(
          color: const Color(0xFF1E88E5), // Blue
        ),
        child: Stack(
          children: [
            // Background truck icon
            Positioned(
              right: -30,
              bottom: -20,
              child: Icon(
                Icons.local_shipping,
                size: 140,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
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
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.local_shipping,
                                color: Color(0xFF1E88E5),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'شحن مجاني',
                                style: OfferStyles.subtitleStyle.copyWith(
                                  color: const Color(0xFF1E88E5),
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
          ],
        ),
      ),
    );
  }
}
