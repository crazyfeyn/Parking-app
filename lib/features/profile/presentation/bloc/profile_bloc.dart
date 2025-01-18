import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/features/profile/domain/entity/profile_entity.dart';
import 'package:flutter_application/features/profile/domain/usecases/add_payment_method_usecase.dart';
import 'package:flutter_application/features/profile/domain/usecases/generate_client_secret_usecase.dart';
import 'package:flutter_application/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:flutter_application/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AddPaymentMethodUsecase addPaymentMethodUsecase;
  final GetProfileUsecase getProfileUsecase;
  final UpdateProfileUsecase updateProfileUsecase;
  final GenerateClientSecretKeyUsecase generateClientSecretKeyUsecase;

  ProfileBloc({
    required this.addPaymentMethodUsecase,
    required this.getProfileUsecase,
    required this.updateProfileUsecase,
    required this.generateClientSecretKeyUsecase,
  }) : super(ProfileState()) {
    on<_getProfile>(_onGetProfile);
    on<_updateProfile>(_onUpdateProfile);
    on<_addPaymentMethod>(_onAddPaymentMethod);
    on<_generateClientSecretKey>(_onGenerateClientSecretKey);
  }

  Future<void> _onGetProfile(
      _getProfile event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: Status.loading));

    final result = await getProfileUsecase(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(
          status: Status.error, message: _failureMessage(failure))),
      (profile) => emit(
        state.copyWith(profile: profile, status: Status.success),
      ),
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
      (_) {
        print('successs');
        emit(state.copyWith(status: Status.success));
      },
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

  Future<void> _onGenerateClientSecretKey(
      _generateClientSecretKey event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: Status.loading));

    final result = await generateClientSecretKeyUsecase(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(message: _failureMessage(failure))),
      (clientSecret) => emit(state.copyWith(clientSecret: clientSecret)),
    );
  }
}
