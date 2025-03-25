import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/home_repository_implementation.dart';
import '../../domain/entities/products_model/rate.dart';

part 'product_detials_state.dart';

class ProductDetialsCubit extends Cubit<ProductDetialsState> {
  final HomeRepositoryImplementation homeRepoImple;

  ProductDetialsCubit(this.homeRepoImple) : super(ProductDetialsInitial());
  static ProductDetialsCubit get(context) => BlocProvider.of(context);

  Future<void> getProductDetails(String productId) async {
    emit(ProductRatingLoading());
    try {
      final List<Rate> productRating =
          await homeRepoImple.getProductRating(productId);
      final double averageRating =
          await homeRepoImple.getAverageProductRating(productId);
      emit(ProductRatingSuccess(productRating, averageRating));
    } catch (e) {
      emit(ProductRatingError(e.toString()));
    }
  }

  Future<void> addOrUpdateRating(String productId, Rate rate) async {
    emit(AddOrUpdateRatingLoading());
    try {
      await homeRepoImple.addOrUpdateRating(productId, rate);
      emit(AddOrUpdateRatingSuccess('Rating added/updated successfully'));
      // Optionally, you can refresh the product details after adding/updating the rating
      await getProductDetails(productId);
    } catch (e) {
      emit(AddOrUpdateRatingError(e.toString()));
    }
  }
}
