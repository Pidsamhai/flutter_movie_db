import 'package:bloc/bloc.dart' as bloc;
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';

import 'base_state.dart';

class BasicState<T> extends Union4Impl<Initial, Loading, Success<T>, Failure> {
  BasicState._(Union4<Initial, Loading, Success<T>, Failure> union)
      : super(union);

  factory BasicState.initial(
          Quartet<Initial, Loading, Success<T>, Failure> unions) =>
      BasicState._(unions.first(const Initial()));

  factory BasicState.loading(
          Quartet<Initial, Loading, Success<T>, Failure> unions) =>
      BasicState._(unions.second(const Loading()));

  factory BasicState.success(
          Quartet<Initial, Loading, Success<T>, Failure> unions,
          {required T data}) =>
      BasicState._(unions.third(Success<T>(data)));

  factory BasicState.failure(
          Quartet<Initial, Loading, Success<T>, Failure> unions,
          {required String error}) =>
      BasicState._(unions.fourth(Failure(error: error)));
}

class Success<T> extends BaseState {
  final T result;
  Success(this.result);
}

abstract class BasicCubit<T> extends Cubit<BasicState<T>> {
  BasicCubit(BasicState<T> initialState) : super(initialState);
}

abstract class BasicQuartet<T>
    extends Quartet<Initial, Loading, Success<T>, Failure> {
  BasicQuartet();
}