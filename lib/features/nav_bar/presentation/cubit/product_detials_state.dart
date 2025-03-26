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
  final List<Comment> comments;

  const ProductRatingSuccess(
      this.productRating, this.averageRating, this.comments);

  @override
  List<Object> get props => [productRating, averageRating, comments];
}

class ProductRatingError extends ProductDetialsState {
  final String error;

  const ProductRatingError(this.error);

  @override
  List<Object> get props => [error];
}

// New state for category products
class CategoryProductsLoading extends ProductDetialsState {}

class CategoryProductsSuccess extends ProductDetialsState {
  final List<ProductsModel> products;

  const CategoryProductsSuccess(this.products);

  @override
  List<Object> get props => [products];
}

class CategoryProductsError extends ProductDetialsState {
  final String error;

  const CategoryProductsError(this.error);

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

// New states for addComment
class AddCommentLoading extends ProductDetialsState {}

class AddCommentSuccess extends ProductDetialsState {
  final String message;

  const AddCommentSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class AddCommentError extends ProductDetialsState {
  final String error;

  const AddCommentError(this.error);

  @override
  List<Object> get props => [error];
}
