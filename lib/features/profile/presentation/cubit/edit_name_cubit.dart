import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../../core/services/service_locator.dart';
import '../../domain/repositories/profile_repository.dart';

part 'edit_name_state.dart';

class EditNameCubit extends Cubit<EditNameState> {
  final ProfileRepository _repository;
  final logger = locator<Logger>();

  final TextEditingController nameController = TextEditingController();

  EditNameCubit(this._repository) : super(EditNameInitial());

  Future<void> updateName() async {
    final name = nameController.text;
    if (name.isEmpty) {
      emit(EditNameError('Name cannot be empty'));
      return;
    }

    emit(EditNameLoading());
    try {
      await _repository.updateUserName(name);
      emit(EditNameSuccess());
    } catch (e) {
      logger.e(e.toString());
      emit(EditNameError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    return super.close();
  }
}
