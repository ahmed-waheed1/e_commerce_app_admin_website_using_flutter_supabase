import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/services/dio_service.dart';
import '../../../../core/services/end_points.dart';
import '../../../../core/services/service_locator.dart';
import '../../../Authentication/data/models/user_data_model.dart';
import '../../domain/entities/products_model/comment.dart';
import '../../domain/entities/products_model/products_model.dart';
import '../../domain/entities/products_model/rate.dart';
import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImplementation implements HomeRepository {
  final DioService dioService;
  final logger = locator<Logger>();
  HomeRepositoryImplementation(this.dioService);
  String userId = Supabase.instance.client.auth.currentUser!.id;

  @override
  Future<List<ProductsModel>> getHomeData() async {
    try {
      final response = await dioService.get(
        EndPoints.getAllProducts,
      );
      logger.d('Response: ${response.data}');
      logger.d('Status Code: ${response.statusCode}');
      logger.d('Status Message: ${response.statusMessage}');
      if (response.statusCode == 200) {
        logger.d('Data: ${response.data}');
        List<ProductsModel> products = (response.data as List)
            .map((item) => ProductsModel.fromJson(item))
            .toList();
        return products;
      } else if (response.statusCode == 401) {
        logger.e('Unauthorized: ${response.statusMessage}');
        throw Exception('Unauthorized');
      } else if (response.statusCode == 404) {
        logger.e('Not Found: ${response.statusMessage}');
        throw Exception('Not Found');
      } else if (response.statusCode == 500) {
        logger.e('Server Error: ${response.statusMessage}');
        throw Exception('Server Error');
      } else {
        logger.e('Error: ${response.statusCode} - ${response.statusMessage}');
        throw Exception('Unexpected error occurred');
      }
    } catch (e) {
      logger.e('Exception: $e');
      throw Exception('Unexpected error occurred');
    }
  }

  @override
  Future<List<Rate>> getProductRating(String productId) async {
    try {
      productId = productId.trim().replaceAll(RegExp(r'^/+|/+$'), '');
      if (!Uuid.isValidUUID(fromString: productId)) {
        throw Exception('Invalid productId');
      }
      final response = await dioService.get(
        '${EndPoints.getProductRating}$productId',
      );
      logger.d('Response: ${response.data}');
      logger.d('Status Code: ${response.statusCode}');
      logger.d('Status Message: ${response.statusMessage}');
      if (response.statusCode == 200) {
        logger.d('Data: ${response.data}');
        List<Rate> productRating =
            (response.data as List).map((item) => Rate.fromJson(item)).toList();
        return productRating;
      } else if (response.statusCode == 401) {
        logger.e('Unauthorized: ${response.statusMessage}');
        throw Exception('Unauthorized');
      } else if (response.statusCode == 404) {
        logger.e('Not Found: ${response.statusMessage}');
        throw Exception('Not Found');
      } else if (response.statusCode == 500) {
        logger.e('Server Error: ${response.statusMessage}');
        throw Exception('Server Error');
      } else {
        logger.e('Error: ${response.statusCode} - ${response.statusMessage}');
        throw Exception('Unexpected error occurred');
      }
    } catch (e) {
      logger.e('Exception: $e');
      throw Exception('Unexpected error occurred');
    }
  }

  @override
  Future<double> getAverageProductRating(String productId) async {
    try {
      List<Rate> productRatings = await getProductRating(productId);
      if (productRatings.isEmpty) {
        return 0.0;
      }
      double totalRating =
          productRatings.fold(0, (sum, item) => sum + (item.rate ?? 0));
      double averageRating = totalRating / productRatings.length;
      logger.d('Average Rating: $averageRating');
      if (averageRating.isNaN) {
        logger.e('Average rating is NaN');
        throw Exception('Average rating is NaN');
      }
      return averageRating;
    } catch (e) {
      logger.e('Exception: $e');
      throw Exception(
          'Unexpected error occurred while calculating average rating');
    }
  }

  @override
  Future<void> addOrUpdateRating(String productId, Rate rate) async {
    try {
      productId = productId.trim().replaceAll(RegExp(r'^/+|/+$'), '');
      if (!Uuid.isValidUUID(fromString: productId)) {
        throw Exception('Invalid productId');
      }
      rate = rate.copyWith(forUser: userId, forProduct: productId);
      final existingRatings = await getProductRating(productId);
      final existingRating = existingRatings.firstWhere(
          (r) => r.forUser == rate.forUser,
          orElse: () => Rate(forUser: rate.forUser, rate: 0));
      if (existingRating.rate == 0) {
        final response = await dioService.post(
          EndPoints.addProductRating(productId),
          data: rate.toMap(),
        );
        logger.d('Response: ${response.data}');
        logger.d('Status Code: ${response.statusCode}');
        logger.d('Status Message: ${response.statusMessage}');
        if (response.statusCode != 201) {
          throw Exception('Failed to add rating');
        }
      } else {
        final response = await dioService.patch(
          EndPoints.updateProductRating(userId, productId),
          data: rate.toMap(),
        );
        logger.d('Response: ${response.data}');
        logger.d('Status Code: ${response.statusCode}');
        logger.d('Status Message: ${response.statusMessage}');
      }
    } catch (e) {
      logger.e('Exception: $e');
      throw Exception('Unexpected error occurred while adding/updating rating');
    }
  }

  @override
  Future<void> addComment(String productId, Comment comment) async {
    try {
      productId = productId.trim().replaceAll(RegExp(r'^/+|/+$'), '');
      if (!Uuid.isValidUUID(fromString: productId)) {
        throw Exception('Invalid productId');
      }
      comment = comment.copyWith(forUser: userId, forProduct: productId);
      final response = await dioService.post(
        EndPoints.addComment(productId),
        data: comment.toMap(),
      );
      logger.d('Response: ${response.data}');
      logger.d('Status Code: ${response.statusCode}');
      logger.d('Status Message: ${response.statusMessage}');
      if (response.statusCode != 201) {
        throw Exception('Failed to add comment');
      }
    } catch (e) {
      logger.e('Exception: $e');
      throw Exception('Unexpected error occurred while adding comment');
    }
  }

  @override
  Future<List<Comment>> getProductComments(String productId) async {
    try {
      productId = productId.trim().replaceAll(RegExp(r'^/+|/+$'), '');
      if (!Uuid.isValidUUID(fromString: productId)) {
        throw Exception('Invalid productId');
      }
      final response = await dioService.get(
        EndPoints.getProductComments(productId),
      );
      logger.d('Response: ${response.data}');
      logger.d('Status Code: ${response.statusCode}');
      logger.d('Status Message: ${response.statusMessage}');
      if (response.statusCode == 200) {
        logger.d('Data: ${response.data}');
        List<Comment> comments = (response.data as List)
            .map((item) => Comment.fromJson(item))
            .toList();
        return comments;
      } else if (response.statusCode == 401) {
        logger.e('Unauthorized: ${response.statusMessage}');
        throw Exception('Unauthorized');
      } else if (response.statusCode == 404) {
        logger.e('Not Found: ${response.statusMessage}');
        throw Exception('Not Found');
      } else if (response.statusCode == 500) {
        logger.e('Server Error: ${response.statusMessage}');
        throw Exception('Server Error');
      } else {
        logger.e('Error: ${response.statusCode} - ${response.statusMessage}');
        throw Exception('Unexpected error occurred');
      }
    } catch (e) {
      logger.e('Exception: $e');
      throw Exception('Unexpected error occurred');
    }
  }

  @override
  Future<Map<String, UserDataModel>> getUserMap() async {
    try {
      final response = await dioService.get(
        EndPoints.getAllUsers,
      );
      logger.d('Response: ${response.data}');
      logger.d('Status Code: ${response.statusCode}');
      logger.d('Status Message: ${response.statusMessage}');
      if (response.statusCode == 200) {
        logger.d('Data: ${response.data}');
        List<UserDataModel> users = (response.data as List)
            .map((item) => UserDataModel.fromJson(item))
            .toList();
        return {for (var user in users) user.userId: user};
      } else if (response.statusCode == 401) {
        logger.e('Unauthorized: ${response.statusMessage}');
        throw Exception('Unauthorized');
      } else if (response.statusCode == 404) {
        logger.e('Not Found: ${response.statusMessage}');
        throw Exception('Not Found');
      } else if (response.statusCode == 500) {
        logger.e('Server Error: ${response.statusMessage}');
        throw Exception('Server Error');
      } else {
        logger.e('Error: ${response.statusCode} - ${response.statusMessage}');
        throw Exception('Unexpected error occurred');
      }
    } catch (e) {
      logger.e('Exception: $e');
      throw Exception('Unexpected error occurred');
    }
  }

  @override
  Future<List<ProductsModel>> getProductsByCategory(String categoryName) async {
    try {
      final response = await dioService.get(
        EndPoints.getProductsByCategory(categoryName),
      );
      logger.d('Response: ${response.data}');
      logger.d('Status Code: ${response.statusCode}');
      logger.d('Status Message: ${response.statusMessage}');
      if (response.statusCode == 200) {
        logger.d('Data: ${response.data}');
        List<ProductsModel> products = (response.data as List)
            .map((item) => ProductsModel.fromJson(item))
            .toList();
        return products;
      } else if (response.statusCode == 401) {
        logger.e('Unauthorized: ${response.statusMessage}');
        throw Exception('Unauthorized');
      } else if (response.statusCode == 404) {
        logger.e('Not Found: ${response.statusMessage}');
        throw Exception('Not Found');
      } else if (response.statusCode == 500) {
        logger.e('Server Error: ${response.statusMessage}');
        throw Exception('Server Error');
      } else {
        logger.e('Error: ${response.statusCode} - ${response.statusMessage}');
        throw Exception('Unexpected error occurred');
      }
    } catch (e) {
      logger.e('Exception: $e');
      throw Exception('Unexpected error occurred');
    }
  }
}
