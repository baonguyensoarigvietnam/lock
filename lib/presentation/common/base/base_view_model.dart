// ignore_for_file: unintended_html_in_doc_comment

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';
import 'package:applock/utility/helper/result.dart';

/// Base class for all states in view models. Tracks status and error messages.
@immutable
abstract class BaseState {
  final ViewStatus status;
  final String? errorMessage;

  const BaseState({this.status = ViewStatus.initial, this.errorMessage});

  /// Concrete subclasses must override to allow easy state modifications.
  BaseState copyWith({ViewStatus? status, Nullable<String>? errorMessage});

  /// True if state is the initial state.
  bool get isInitial => status == ViewStatus.initial;

  /// True if a loading process is ongoing.
  bool get isLoading => status == ViewStatus.loading;

  /// True if last operation was successful.
  bool get isSuccess => status == ViewStatus.success;

  /// True if last operation failed.
  bool get isFailure => status == ViewStatus.failure;

  /// True if there is an error message.
  bool get hasError => errorMessage != null;
}

/// Mixin containing common call-data-handling logic for Bloc & Cubit base classes.
mixin BaseCallDataHandler<S extends BaseState> on BlocBase<S> {
  /// Handles an operation that returns a [Result], manages state, and calls callbacks.
  Future<void> handleCallData<R>({
    required Future<Result<R>> apiCall,
    required FutureOr<void> Function(R result) onSuccess,
    FutureOr<void> Function(
      Object error,
      String? errorMessage,
      Map<String, List<String>>? errorDetail,
    )? onError,
    bool showLoading = true,
  }) async {
    if (showLoading) {
      emitLoading();
    }

    final result = await apiCall;

    switch (result) {
      case Success(data: final data):
        await onSuccess(data);
      case Error(error: final error):
        if (onError != null) {
          await onError(error, result.message, result.errorDetails);
        } else {
          emitError(result.message ?? '');
        }
    }
  }

  /// Handles a Stream<R>, managing state for each incoming data point.
  Future<void> handleStreamData<R>({
    required Emitter<S> emit,
    required Stream<Result<R>> streamData,
    required FutureOr<void> Function(R data) onSuccess,
    FutureOr<void> Function(
      Object error,
      String? errorMessage,
      Map<String, List<String>>? errorDetail,
    )? onError,
    bool showLoading = true,
  }) async {
    if (showLoading) {
      emitLoading();
    }

    await emit.forEach<Result<R>>(
      streamData,
      onData: (result) {
        switch (result) {
          case Success(data: final data):
            onSuccess(data);
            return state;
          case Error(error: final error):
            if (onError != null) {
              onError(error, result.message, result.errorDetails);
            } else {
              emitError(result.message ?? '');
            }
            return state;
        }
      },
      onError: (error, _) {
        emitError(error.toString());
        return state;
      },
    );

    if (state.status == ViewStatus.loading) {
      emit(state.copyWith(status: ViewStatus.success) as S);
    }
  }

  /// Emits a loading state using the state's copyWith.
  void emitLoading() => emit(state.copyWith(status: ViewStatus.loading) as S);

  /// Emits an error state with the given error message.
  void emitError(String errorMessage) => emit(
    state.copyWith(
      errorMessage: Nullable(errorMessage),
      status: ViewStatus.failure,
    ) as S,
  );

  /// Clears the error part of the state.
  void emitClearedError() =>
      emit(state.copyWith(errorMessage: const Nullable(null)) as S);
}

/// Base class for Cubit-style state management, provides access to [BaseCallDataHandler].
abstract class BaseCubit<S extends BaseState> extends Cubit<S>
    with BaseCallDataHandler<S> {
  BaseCubit(super.initialState);

  @override
  void emit(S state) {
    if (isClosed) return;
    super.emit(state);
  }
}

/// Base class for Bloc-style state management.
abstract class BaseBloc<E, S extends BaseState> extends Bloc<E, S>
    with BaseCallDataHandler<S> {
  BaseBloc(super.initialState);
}
