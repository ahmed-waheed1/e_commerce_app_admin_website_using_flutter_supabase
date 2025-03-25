import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/nav_bar/data/repositories/home_repository_implementation.dart';
import '../../features/nav_bar/presentation/cubit/home_cubit.dart';
import '../../features/nav_bar/presentation/widgets/custom_product_card.dart';
import '../services/service_locator.dart';

class CustomProductList extends StatelessWidget {
  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  const CustomProductList({
    super.key,
    this.shrinkWrap,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        locator<HomeRepositoryImplementation>(),
      )..getHomeData(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoaded) {
            return ListView.builder(
              shrinkWrap: shrinkWrap ?? true,
              physics: physics ?? const NeverScrollableScrollPhysics(),
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                final product = state.data[index];
                return CustomProductCard(
                  product: product,
                );
              },
            );
          } else if (state is HomeError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('Unexpected state'));
          }
        },
      ),
    );
  }
}
