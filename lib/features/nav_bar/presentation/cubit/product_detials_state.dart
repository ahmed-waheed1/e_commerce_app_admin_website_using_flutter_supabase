part of 'product_detials_cubit.dart';

abstract class ProductDetialsState extends Equatable {
  const ProductDetialsState();

  @override
  List<Object> get props => [];
}

class ProductDetialsInitial extends ProductDetialsState {}

class ProductRatingLoading extends ProductDetialsState {}

class ProductRatingSuccess extends ProductDetialsState {
  final List<Rate> productRating;
  final double averageRating;

  const ProductRatingSuccess(this.productRating, this.averageRating);

  @override
  List<Object> get props => [productRating, averageRating];
}

class ProductRatingError extends ProductDetialsState {
  final String error;

  const ProductRatingError(this.error);

  @override
  List<Object> get props => [error];
}

// New states for addOrUpdateRating
class AddOrUpdateRatingLoading extends ProductDetialsState {}

class AddOrUpdateRatingSuccess extends ProductDetialsState {
  final String message;

  const AddOrUpdateRatingSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class AddOrUpdateRatingError extends ProductDetialsState {
  final String error;

  const AddOrUpdateRatingError(this.error);

  @override
  List<Object> get props => [error];
}
