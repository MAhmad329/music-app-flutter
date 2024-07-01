import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:music_app/core/providers/current_user_notifier.dart';
import 'package:music_app/features/auth/model/user_model.dart';
import 'package:music_app/features/auth/repositories/auth_local_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repositories/auth_remote_repository.dart';

part 'auth_viewmodel.g.dart';

enum AuthOperation { login, signup }

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepository _authRemoteRepository;
  late AuthLocalRepository _authLocalRepository;
  late CurrentUserNotifier _currentUserNotifier;
  AuthOperation? _operation;

  @override
  AsyncValue<UserModel>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    _currentUserNotifier = ref.watch(currentUserNotifierProvider.notifier);

    return null;
  }

  Future<void> initSharedPreferences() async {
    await _authLocalRepository.init();
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    _operation = AuthOperation.login;
    state = const AsyncValue.loading();
    // await initSharedPreferences();
    final res = await _authRemoteRepository.login(
      email: email,
      password: password,
    );

    final val = switch (res) {
      Left(value: final l) => state = AsyncValue.error(
          l.message,
          StackTrace.current,
        ),
      Right(value: final r) => _loginSuccess(r),
    };
    print(val);
  }

  AsyncValue<UserModel>? _loginSuccess(UserModel user) {
    _authLocalRepository.setToken(user.token);
    _currentUserNotifier.addUser(user);
    return state = AsyncValue.data(user);
  }

  Future<void> signUpUser({
    required String name,
    required String email,
    required String password,
  }) async {
    _operation = AuthOperation.signup;
    state = const AsyncValue.loading();
    // await initSharedPreferences();
    final res = await _authRemoteRepository.signup(
      name: name,
      email: email,
      password: password,
    );

    final val = switch (res) {
      Left(value: final l) => state = AsyncValue.error(
          l.message,
          StackTrace.current,
        ),
      Right(value: final r) => state = AsyncValue.data(r),
    };
    print(val);
  }

  Future<UserModel?> getData() async {
    state = const AsyncValue.loading();
    final token = _authLocalRepository.getToken();
    if (token != null) {
      final res = await _authRemoteRepository.getCurrentUserData(token);
      final val = switch (res) {
        Left(value: final l) => state = AsyncValue.error(
            l.message,
            StackTrace.current,
          ),
        Right(value: final r) => _getDataSuccess(r),
      };
      return val.value;
    }
    return null;
  }

  AsyncValue<UserModel> _getDataSuccess(UserModel user) {
    _currentUserNotifier.addUser(user);
    return state = AsyncValue.data(user);
  }

  // ignore: avoid_public_notifier_properties
  AuthOperation? get operation => _operation;
}
