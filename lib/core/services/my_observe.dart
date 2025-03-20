import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import 'service_locator.dart';

class MyObserve implements BlocObserver {
  final logger = locator<Logger>();
  @override
  void onCreate(BlocBase bloc) {
    logger.i('onCreate: $bloc');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    logger.i('onEvent: $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    logger.i('onChange: $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    logger.i('onTransition: $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.i('onError: $error');
  }

  @override
  void onClose(BlocBase bloc) {
    logger.i('onClose: $bloc');
  }
}
