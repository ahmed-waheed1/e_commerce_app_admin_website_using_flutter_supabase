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

// New states for handling favorites
class AddFavoriteLoading extends ProductDetialsState {}

class AddFavoriteSuccess extends ProductDetialsState {
  final String message;

  const AddFavoriteSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class AddFavoriteError extends ProductDetialsState {
  final String error;

  const AddFavoriteError(this.error);

  @override
  List<Object> get props => [error];
}

class RemoveFavoriteLoading extends ProductDetialsState {}

class RemoveFavoriteSuccess extends ProductDetialsState {
  final String message;

  const RemoveFavoriteSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class RemoveFavoriteError extends ProductDetialsState {
  final String error;

  const RemoveFavoriteError(this.error);

  @override
  List<Object> get props => [error];
}

class GetFavoritesLoading extends ProductDetialsState {}

class GetFavoritesSuccess extends ProductDetialsState {
  final List<Favorite> favorites;

  const GetFavoritesSuccess(this.favorites);

  @override
  List<Object> get props => [favorites];
}

class GetFavoritesError extends ProductDetialsState {
  final String error;

  const GetFavoritesError(this.error);

  @override
  List<Object> get props => [error];
}
