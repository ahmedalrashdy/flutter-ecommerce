import 'package:flutter/material.dart';
import 'offer_styles.dart';

enum SeasonalOfferType {
  eid,
  valentines,
  christmas,
}

class SeasonalOfferCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final SeasonalOfferType offerType;
  final VoidCallback onTap;

  const SeasonalOfferCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.offerType,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 180,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: OfferStyles.cardDecoration(
          color: _getSeasonalColor(),
        ),
        child: Stack(
          children: [
            // Background seasonal icon
            Positioned(
              right: -30,
              top: -30,
              child: Icon(
                _getSeasonalIcon(),
                size: 160,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        _getSeasonalIcon(),
                        color: Colors.white,
                        size: 32,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        title,
                        style: OfferStyles.titleStyle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
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
                        Icon(
                          _getSeasonalIcon(),
                          color: _getSeasonalColor(),
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _getSeasonalMessage(),
                          style: OfferStyles.subtitleStyle.copyWith(
                            color: _getSeasonalColor(),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Decorative elements
            if (offerType == SeasonalOfferType.eid)
              ..._buildEidDecorations()
            else if (offerType == SeasonalOfferType.valentines)
              ..._buildValentinesDecorations()
            else
              ..._buildChristmasDecorations(),
          ],
        ),
      ),
    );
  }

  Color _getSeasonalColor() {
    switch (offerType) {
      case SeasonalOfferType.eid:
        return const Color(0xFF2E7D32); // Dark Green
      case SeasonalOfferType.valentines:
        return const Color(0xFFD32F2F); // Red
      case SeasonalOfferType.christmas:
        return const Color(0xFFC62828); // Dark Red
    }
  }

  IconData _getSeasonalIcon() {
    switch (offerType) {
      case SeasonalOfferType.eid:
        return Icons.mosque;
      case SeasonalOfferType.valentines:
        return Icons.favorite;
      case SeasonalOfferType.christmas:
        return Icons.park;
    }
  }

  String _getSeasonalMessage() {
    switch (offerType) {
      case SeasonalOfferType.eid:
        return 'عروض العيد بدأت!';
      case SeasonalOfferType.valentines:
        return 'عروض عيد الحب!';
      case SeasonalOfferType.christmas:
        return 'عروض نهاية العام!';
    }
  }

  List<Widget> _buildEidDecorations() {
    return [
      Positioned(
        left: 20,
        top: 20,
        child: Icon(
          Icons.star,
          size: 24,
          color: Colors.white.withOpacity(0.3),
        ),
      ),
      Positioned(
        right: 40,
        bottom: 40,
        child: Icon(
          Icons.brightness_2,
          size: 32,
          color: Colors.white.withOpacity(0.3),
        ),
      ),
    ];
  }

  List<Widget> _buildValentinesDecorations() {
    return [
      Positioned(
        left: 30,
        top: 30,
        child: Icon(
          Icons.favorite,
          size: 20,
          color: Colors.white.withOpacity(0.3),
        ),
      ),
      Positioned(
        right: 50,
        bottom: 30,
        child: Icon(
          Icons.favorite,
          size: 28,
          color: Colors.white.withOpacity(0.3),
        ),
      ),
    ];
  }

  List<Widget> _buildChristmasDecorations() {
    return [
      Positioned(
        left: 20,
        top: 40,
        child: Icon(
          Icons.ac_unit,
          size: 24,
          color: Colors.white.withOpacity(0.3),
        ),
      ),
      Positioned(
        right: 60,
        bottom: 30,
        child: Icon(
          Icons.star,
          size: 32,
          color: Colors.white.withOpacity(0.3),
        ),
      ),
    ];
  }
}
