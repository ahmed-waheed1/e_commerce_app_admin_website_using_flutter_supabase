import 'package:equatable/equatable.dart';

abstract class NavBarState extends Equatable {
  final int index;
  const NavBarState(this.index);

  @override
  List<Object> get props => [index];
}

class NavBarInitial extends NavBarState {
  const NavBarInitial() : super(0);
}

class NavBarChanged extends NavBarState {
  const NavBarChanged(super.index);
}
