abstract class ApiEndpoint {
  // =============== Categories Endpoints ===============
  static const String mainCategories = "categories";
  static const String retrieveCategory = "categories/";
  static String childrenOfCategory(int pk) => "categories/$pk/children/";
  static String descendantsOfCategory(int pk) => "categories/$pk/descendants/";

  // =============== Products Endpoints ===============
  static String productRetrieve(int pk) => "products/$pk/";

  static const String productsBestSeller = "products/best_seller/";
  static String productsBestSellerOfCategory(int categoryId) =>
      "products/best_seller/$categoryId";

  static const String productsRecent = "products/recent/";
  static String productsRecentOfCategory(int categoryId) =>
      "products/recent/$categoryId";

  static const String productsTapRated = "products/tap_rated/";
  static String productsTapRatedOfCategory(int categoryId) =>
      "products/tap_rated/$categoryId";
  static String productsOfCategory(int categoryId) =>
      "products/category/$categoryId";

  //Auth
  static const String login = "auth/login/";
  static const String register = "auth/register/";

  //Cart
  static const String cartList = "cart";
  static const String addProductToCart = "cart/add/";
  static const String deleteCartItem = "cart/delete/";

  static const String addAddress = "addresses/create/";
  static const String allAddresses = "addresses/";
  static String deleteAddress(int addressId) =>
      "addresses/${addressId}/delete/";

  static const String createPaymentIntent = "create-payment-intent/";

  //orders
  static const String getAllOrders = "orders/";
  static String cancelOrder(int orderId) => "orders/${orderId}/cancel/";
}
