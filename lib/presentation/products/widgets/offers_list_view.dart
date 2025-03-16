import 'package:flutter/material.dart';
import 'package:super_ecommerce/core/constants/app_assets.dart';
import 'discount_offer_card.dart';
import 'shipping_offer_card.dart';
import 'gift_offer_card.dart';
import 'bundle_offer_card.dart';
import 'seasonal_offer_card.dart';

class OffersListView extends StatelessWidget {
  const OffersListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildOffersList(context);
  }

  Widget _buildOffersList(BuildContext context) {
    return SizedBox(
      // height: 250,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: List.generate(
              5,
              (index) => Column(
                    children: [
                      SizedBox(
                        width: 450,
                        height: 240,
                        child: AspectRatio(
                          aspectRatio: 450 / 300,
                          child: _getOfferCard(index),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                    ],
                  )),
        ),
      ),
    );
  }

  Widget _getOfferCard(int index) {
    switch (index) {
      case 0:
        return DiscountOfferCard(
          title: 'خصم هائل لفترة محدودة',
          subtitle: 'وفر حتى 50٪ على منتجات مختارة',
          discountPercentage: '50',
          onTap: () {},
        );
      case 1:
        return SeasonalOfferCard(
          title: 'عروض العيد السعيد',
          subtitle: 'استمتع بخصومات حصرية بمناسبة العيد',
          offerType: SeasonalOfferType.eid,
          onTap: () {},
        );
      case 2:
        return ShippingOfferCard(
          title: 'شحن مجاني للجميع',
          subtitle: 'على جميع الطلبات التي تزيد عن 200 ريال',
          onTap: () {},
        );
      case 3:
        return BundleOfferCard(
          title: 'عرض الباقة المميزة',
          subtitle: 'وفر أكثر مع باقة المنتجات المختارة',
          originalPrice: 499.99,
          discountedPrice: 299.99,
          productImages: [
            AppAssets.imagesCategory,
            AppAssets.imagesProduct,
            AppAssets.imagesOnboardingFood,
          ],
          onTap: () {},
        );
      default:
        return GiftOfferCard(
          title: 'هدية مع كل طلب',
          subtitle: 'اطلب الآن واحصل على هدية مجانية قيمة',
          giftDescription: 'هدية مفاجئة مع كل طلب يزيد عن 300 ريال',
          onTap: () {},
        );
    }
  }
}

// Enhanced Shimmer Loading Effect
class OffersLoadingShimmer extends StatelessWidget {
  const OffersLoadingShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header shimmer
        Container(
          height: 80,
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),
          child: const LoadingShimmerEffect(),
        ),
        // Featured offers shimmer
        Container(
          height: 180,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView.builder(
            shrinkWrap: false,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                width: 160,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const LoadingShimmerEffect(),
              );
            },
          ),
        ),
        // Main offers shimmer
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          itemCount: 4,
          itemBuilder: (context, index) {
            return Container(
              height: 160,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: const LoadingShimmerEffect(),
            );
          },
        ),
      ],
    );
  }
}

// Shimmer effect animation
class LoadingShimmerEffect extends StatefulWidget {
  const LoadingShimmerEffect({Key? key}) : super(key: key);

  @override
  State<LoadingShimmerEffect> createState() => _LoadingShimmerEffectState();
}

class _LoadingShimmerEffectState extends State<LoadingShimmerEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: -2, end: 2).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.grey[200]!,
                Colors.grey[300]!,
                Colors.grey[200]!,
              ],
              stops: [
                0.0,
                _animation.value,
                1.0,
              ],
            ),
          ),
        );
      },
    );
  }
}
