import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/favorite_view.dart';
import '../pages/home_view.dart';
import '../pages/profile_view.dart';
import '../pages/store_view.dart';
import 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  final List<Widget> views = [
    const HomeView(),
    const StoreView(),
    const FavoriteView(),
    const ProfileView(),
  ];

  NavBarCubit() : super(NavBarInitial());

  void changeTab(int index) {
    emit(NavBarChanged(index));
  }
}
