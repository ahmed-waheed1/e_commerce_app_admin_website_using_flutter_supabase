import 'package:flutter_bloc/flutter_bloc.dart';

class VisiabilityCubit extends Cubit<bool> {
  VisiabilityCubit() : super(false);

  void toggleVisibility() {
    emit(!state);
  }
}
