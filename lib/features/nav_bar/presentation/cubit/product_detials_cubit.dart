import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Authentication/data/models/user_data_model.dart';
import '../../data/repositories/home_repository_implementation.dart';
import '../../domain/entities/products_model/comment.dart';
import '../../domain/entities/products_model/products_model.dart';
import '../../domain/entities/products_model/rate.dart';

part 'product_detials_state.dart';

class ProductDetialsCubit extends Cubit<ProductDetialsState> {
  final HomeRepositoryImplementation homeRepoImple;
  final commentController = TextEditingController();

  ProductDetialsCubit(this.homeRepoImple) : super(ProductDetialsInitial());
  static ProductDetialsCubit get(context) => BlocProvider.of(context);

  Future<void> getProductDetails(String productId) async {
    emit(ProductRatingLoading());
    try {
      final List<Rate> productRating =
          await homeRepoImple.getProductRating(productId);
      final double averageRating =
          await homeRepoImple.getAverageProductRating(productId);
      final List<Comment> comments =
          await homeRepoImple.getProductComments(productId);
      final Map<String, UserDataModel> userMap =
          await homeRepoImple.getUserMap();
      final List<Comment> commentsWithUsername = comments.map((comment) {
        return comment.copyWith(username: userMap[comment.forUser]?.name);
      }).toList();
      emit(ProductRatingSuccess(
          productRating, averageRating, commentsWithUsername));
    } catch (e) {
      emit(ProductRatingError(e.toString()));
    }
  }

  Future<void> addOrUpdateRating(String productId, Rate rate) async {
    emit(AddOrUpdateRatingLoading());
    try {
      await homeRepoImple.addOrUpdateRating(productId, rate);
      emit(AddOrUpdateRatingSuccess('Rating added/updated successfully'));
      await getProductDetails(productId);
    } catch (e) {
      emit(AddOrUpdateRatingError(e.toString()));
    }
  }

  Future<void> addComment(String productId, Comment comment) async {
    emit(AddCommentLoading());
    try {
      await homeRepoImple.addComment(productId, comment);
      emit(AddCommentSuccess('Comment added successfully'));
      await getProductDetails(productId);
    } catch (e) {
      emit(AddCommentError(e.toString()));
    }
  }

  Future<void> getProductsByCategory(String categoryName) async {
    emit(CategoryProductsLoading());
    try {
      final List<ProductsModel> products =
          await homeRepoImple.getProductsByCategory(categoryName);
      emit(CategoryProductsSuccess(products));
    } catch (e) {
      emit(CategoryProductsError(e.toString()));
    }
  }

  dispose() {
    commentController.dispose();
  }
}
