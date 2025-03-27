class EndPoints {
  static const String apiBaseUrl =
      'https://hqmlbwzlrnmnkduzvfqf.supabase.co/rest/v1/';

  static String getAllProducts() {
    return '${apiBaseUrl}products?select=*,favorites(*),purchases(*),comments(*),rates(*)';
  }

  static String getProductRating(String productId) {
    return '${apiBaseUrl}rates?select=*,products(*)&for_product=eq.$productId';
  }

  static String getProductRatingById(String productId) {
    return '${apiBaseUrl}rates?select=*,products(*)&for_product=eq.$productId';
  }

  static String addProductRating(String productId) {
    return '${apiBaseUrl}rates?select=*,products(*)&for_product=eq.$productId';
  }

  static String updateProductRating(String userId, String productId) {
    return '${apiBaseUrl}rates?select=*&for_user=eq.$userId&for_product=eq.$productId';
  }

  static String addComment(String productId) {
    return '${apiBaseUrl}comments';
  }

  static String getProductComments(String productId) {
    return '${apiBaseUrl}comments?select=*,products(*)&for_product=eq.$productId';
  }

  static String getAllUsers() {
    return '${apiBaseUrl}users';
  }

  static String getProductsByCategory(String categoryName) {
    return '${apiBaseUrl}products?select=*&category=eq.$categoryName';
  }

  static String addFavorite() {
    return '${apiBaseUrl}favorites';
  }

  static String updateFavorite(String favoriteId) {
    return '${apiBaseUrl}favorites?id=eq.$favoriteId';
  }

  static String getFavorites(String userId) {
    return '${apiBaseUrl}favorites?select=*&for_user=eq.$userId';
  }

  static String getFavoritesByProduct(String userId, String productId) {
    return '${apiBaseUrl}favorites?select=*&for_user=eq.$userId&for_product=eq.$productId';
  }

  static String removeFavorite(String favoriteId) {
    return '${apiBaseUrl}favorites?id=eq.$favoriteId';
  }
}
