String formatPrice(double price) {
  if (price >= 1000000) {
    return '${(price / 1000000).toStringAsFixed(1)}M'; // مثال: 1.5M
  } else if (price >= 1000) {
    return '${(price / 1000).toStringAsFixed(1)}K'; // مثال: 1.2K
  } else {
    return '$price'; // السعر كما هو إذا كان أقل من 1000
  }
}
