import '../entities/products_model/products_model.dart';
import '../entities/products_model/rate.dart';

abstract class HomeRepository {
  Future<List<ProductsModel>> getHomeData();
  // Future<List<ProductsModel>> getProductDetails(int productId);
  Future<List<Rate>> getProductRating(String productId);
  Future<double> getAverageProductRating(String productId); // Add this line
}
