class EndPoints {
  static const String apiBaseUrl =
      'https://hqmlbwzlrnmnkduzvfqf.supabase.co/rest/v1/';
  static const String getAllProducts =
      '${apiBaseUrl}products?select=*,favorites(*),purchases(*),comments(*),rates(*)';
  static const String getProductRating =
      '${apiBaseUrl}rates?select=*,products(*)&for_product=eq.';
  static const String getProductRatingById =
      '${apiBaseUrl}rates?select=*,products(*)&for_product=eq.';
  static String addProductRating(String productId) {
    return '${apiBaseUrl}rates?select=*,products(*)&for_product=eq.$productId';
  }

  static String updateProductRating(String userId, String productId) {
    return '${apiBaseUrl}rates?select=*&for_user=eq.$userId&for_product=eq.$productId';
  }
}
