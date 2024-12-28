import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/features/profile/data/models/profile_model.dart';
import 'package:flutter_application/features/profile/domain/usecases/add_payment_method_usecase.dart';
import 'package:flutter_application/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:flutter_application/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:flutter_application/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AddPaymentMethodUsecase addPaymentMethodUsecase;
  final ChangePasswordUsecase changePasswordUsecase;
  final GetProfileUsecase getProfileUsecase;
  final UpdateProfileUsecase updateProfileUsecase;

  ProfileBloc({
    required this.addPaymentMethodUsecase,
    required this.changePasswordUsecase,
    required this.getProfileUsecase,
    required this.updateProfileUsecase,
  }) : super(ProfileState()) {
    on<_getProfile>(_onGetProfile);
    on<_updateProfile>(_onUpdateProfile);
    on<_changePassword>(_onChangePassword);
    on<_addPaymentMethod>(_onAddPaymentMethod);
  }

  Future<void> _onGetProfile(
      _getProfile event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: Status.loading));

    final result = await getProfileUsecase(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(
          status: Status.error, message: _failureMessage(failure))),
      (profile) => emit(state.copyWith(profile: profile)),
    );
  }

  Future<void> _onUpdateProfile(
      _updateProfile event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: Status.loading));

    final params = UpdateProfileParams(
      name: event.name,
      surname: event.surname,
      email: event.email,
    );

    final result = await updateProfileUsecase(params);
    result.fold(
      (failure) => emit(state.copyWith(
          status: Status.error, message: _failureMessage(failure))),
      (_) => emit(state.copyWith(status: Status.success)),
    );
  }

  Future<void> _onChangePassword(
      _changePassword event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: Status.loading));
    if (event.newPassword.length < 8) {
      emit(state.copyWith(
          status: Status.error, message: 'ERRRORORO'));
      return;
    }

    final params = ChangePasswordParams(
      oldPassword: event.currentPassword,
      newPassword: event.newPassword,
    );

    final result = await changePasswordUsecase(params);
    result.fold(
      (failure) => emit(state.copyWith(
          status: Status.error, message: _failureMessage(failure))),
      (_) => emit(state.copyWith(status: Status.success)),
    );
  }

  Future<void> _onAddPaymentMethod(
      _addPaymentMethod event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: Status.loading));


    final result = await addPaymentMethodUsecase(event.paymentMethod);
    result.fold(
      (failure) => emit(state.copyWith(
          status: Status.error, message: _failureMessage(failure))),
      (_) => emit(state.copyWith(status: Status.success)),
    );
  }

  String _failureMessage(Failure failure) {
    switch (failure) {
      case ServerFailure():
        return 'Server Exception';
      case CacheFailure():
        return "Cache Failure";
      default:
        return "Something get wrong";
    }
  }
}
