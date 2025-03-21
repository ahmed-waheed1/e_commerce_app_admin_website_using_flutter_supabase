import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/services/service_locator.dart';
import '../../data/models/user_data_model.dart';
import '../../domain/repositories/authentication_repository.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationRepository _repository;
  final logger = locator<Logger>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  AuthenticationCubit(this._repository) : super(AuthenticationInitial());

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    emit(LoginLoading());
    try {
      await _repository.login(
        email: emailController.text,
        password: passwordController.text,
      );
      await getUserData();
      emit(LoginSuccess());
    } on AuthException catch (e) {
      logger.e(e.toString());
      emit(LoginError(e.message));
    } catch (e) {
      logger.e(e.toString());
      emit(LoginError(e.toString()));
    }
  }

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;

    emit(SignUpLoading());
    try {
      await _repository.register(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      );
      await addUserData(
        name: nameController.text,
        email: emailController.text,
      );
      await getUserData();
      emit(SignUpSuccess());
    } on AuthException catch (e) {
      logger.e(e.toString());
      emit(SignUpError(e.message));
    } catch (e) {
      logger.e(e.toString());
      emit(SignUpError(e.toString()));
    }
  }

  Future<void> googleSignIn() async {
    emit(GoogleSignInLoading());
    try {
      final response = await _repository.googleSignIn();
      await addUserData(
        name: response.user!.userMetadata!['name'],
        email: response.user!.email!,
      );
      await getUserData();
      emit(GoogleSignInSuccess());
    } catch (e) {
      logger.e(e.toString());
      emit(GoogleSignInError());
    }
  }

  Future<void> signOut() async {
    emit(LogoutLoading());
    try {
      await _repository.signOut();
      emit(LogoutSuccess());
    } catch (e) {
      logger.e(e.toString());
      emit(LogoutError());
    }
  }

  Future<void> resetPassword({required String email}) async {
    emit(PasswordResetLoading());
    try {
      await _repository.resetPassword(email: email);
      emit(PasswordResetSuccess());
    } catch (e) {
      logger.e(e.toString());
      emit(PasswordResetError(
        e.toString(),
      ));
    }
  }

  Future<void> addUserData(
      {required String name, required String email}) async {
    emit(UserDataAddedLoading());
    try {
      await _repository.addUserData(name: name, email: email);
      emit(UserDataAddedSuccess());
    } catch (e) {
      logger.e(e.toString());
      emit(UserDataAddedError());
    }
  }

  UserDataModel? userDataModel;
  Future<void> getUserData() async {
    emit(GetUserDataLoading());
    try {
      userDataModel = (await _repository.getUserData());
      emit(GetUserDataSuccess(
        userDataModel,
      ));
    } catch (e) {
      logger.e(e.toString());
      emit(GetUserDataError(
        e.toString(),
      ));
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long \n and contain at least one uppercase letter, one lowercase letter, and one number';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty';
    }
    return null;
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
