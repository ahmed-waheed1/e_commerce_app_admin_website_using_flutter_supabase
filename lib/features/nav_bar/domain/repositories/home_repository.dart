import '../../../Authentication/data/models/user_data_model.dart';
import '../entities/products_model/comment.dart';
import '../entities/products_model/products_model.dart';
import '../entities/products_model/rate.dart';

abstract class HomeRepository {
  Future<List<ProductsModel>> getHomeData();
  Future<List<Rate>> getProductRating(String productId);
  Future<double> getAverageProductRating(String productId);
  Future<void> addOrUpdateRating(String productId, Rate rate);
  Future<void> addComment(String productId, Comment comment);
  Future<List<Comment>> getProductComments(String productId);
  Future<Map<String, UserDataModel>> getUserMap();
  Future<List<ProductsModel>> getProductsByCategory(String categoryName); // Add this line
}
