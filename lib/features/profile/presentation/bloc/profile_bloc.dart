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
  }) : super(const ProfileState.initial()) {
    on<_getProfile>(_onGetProfile);
    on<_updateProfile>(_onUpdateProfile);
    on<_changePassword>(_onChangePassword);
    on<_addPaymentMethod>(_onAddPaymentMethod);
  }

  Future<void> _onGetProfile(
      _getProfile event, Emitter<ProfileState> emit) async {
    emit(const ProfileState.loading());

    final result = await getProfileUsecase(NoParams());
    result.fold(
      (failure) => emit(const ProfileState.error(message: 'error')),
      (profile) => emit(ProfileState.profileLoaded(profile: profile)),
    );
  }

  Future<void> _onUpdateProfile(
      _updateProfile event, Emitter<ProfileState> emit) async {
    emit(const ProfileState.loading());

    final params = UpdateProfileParams(
      name: event.name,
      surname: event.surname,
      email: event.email,
    );

    final result = await updateProfileUsecase(params);
    result.fold(
      (failure) => emit(const ProfileState.error(message: 'error')),
      (_) => emit(const ProfileState.profileUpdated()),
    );
  }

  Future<void> _onChangePassword(
      _changePassword event, Emitter<ProfileState> emit) async {
    emit(const ProfileState.loading());

    if (event.newPassword.length < 8) {
      emit(const ProfileState.error(
        message: 'Password must be at least 8 characters long',
      ));
      return;
    }

    final params = ChangePasswordParams(
      oldPassword: event.currentPassword,
      newPassword: event.newPassword,
    );

    final result = await changePasswordUsecase(params);
    result.fold(
      (failure) => emit(const ProfileState.error(message: 'error')),
      (_) => emit(const ProfileState.passwordChanged()),
    );
  }

  Future<void> _onAddPaymentMethod(
      _addPaymentMethod event, Emitter<ProfileState> emit) async {
    emit(const ProfileState.loading());

    final result = await addPaymentMethodUsecase(event.paymentMethod);
    result.fold(
      (failure) => emit(const ProfileState.error(message: 'error')),
      (_) => emit(const ProfileState.paymentMethodAdded()),
    );
  }
}
