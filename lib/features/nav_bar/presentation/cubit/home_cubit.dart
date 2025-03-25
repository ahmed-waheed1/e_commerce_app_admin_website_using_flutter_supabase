import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../../../core/services/service_locator.dart';
import '../../data/repositories/home_repository_implementation.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/products_model/products_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepositoryImplementation homeRepoImple;
  final logger = locator<Logger>();
  HomeCubit(this.homeRepoImple) : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  @override
  void onChange(Change<HomeState> change) {
    super.onChange(change);
    logger
        .d('State changed from ${change.currentState} to ${change.nextState}');
  }

  Future<void> getHomeData() async {
    emit(HomeLoading());
    try {
      final List<ProductsModel> products = await homeRepoImple.getHomeData();
      logger.d('Products: $products');
      emit(HomeLoaded(products));
    } catch (e) {
      logger.e('Error: $e');
      emit(HomeError(e.toString()));
    }
  }

  void loadCategories() async {
    emit(HomeLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      final categories = [
        Category(name: 'Electronics', icon: Icons.electrical_services),
        Category(name: 'Fashion', icon: Icons.checkroom),
        Category(name: 'Home', icon: Icons.home),
        Category(name: 'Beauty', icon: Icons.brush),
        Category(name: 'Sports', icon: Icons.sports),
      ];
      emit(HomeLoaded(categories));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
