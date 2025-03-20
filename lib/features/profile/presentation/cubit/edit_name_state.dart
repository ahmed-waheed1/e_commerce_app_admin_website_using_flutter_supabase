part of 'edit_name_cubit.dart';

abstract class EditNameState extends Equatable {
  const EditNameState();

  @override
  List<Object> get props => [];
}

class EditNameInitial extends EditNameState {}

class EditNameLoading extends EditNameState {}

class EditNameSuccess extends EditNameState {}

class EditNameError extends EditNameState {
  final String message;

  const EditNameError(this.message);

  @override
  List<Object> get props => [message];
}
