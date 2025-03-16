import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:super_ecommerce/core/widgets/custom_image.dart';

class OffersCarousel extends StatelessWidget {
  const OffersCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 180,
        viewportFraction: 0.95,
        autoPlay: true,
        enlargeCenterPage: true,
        autoPlayInterval: const Duration(seconds: 4),
      ),
      items: [1, 2, 3].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              width: MediaQuery.of(context).size.width,
              child: CustomImage(
                  fit: BoxFit.cover,
                  imageUrl: 'https://picsum.photos/500/300?random=$i'),
            );
          },
        );
      }).toList(),
    );
  }
}
