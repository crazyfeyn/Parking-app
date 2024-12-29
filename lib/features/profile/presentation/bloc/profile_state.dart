part of 'profile_bloc.dart';
@freezed

class ProfileState with _$ProfileState{
  factory ProfileState({
    @Default(Status.initial) Status status,
    ProfileEntity? profile,
    String? message,
  })=_ProfileState;
}
// class ProfileState with _$ProfileState {
//   const factory ProfileState.initial() = _Initial;

//   // State for loading
//   const factory ProfileState.loading() = _Loading;

//   // State for successfully fetched profile
//   const factory ProfileState.profileLoaded({required ProfileModel profile}) =
//       _ProfileLoaded;

//   // State for profile update success
//   const factory ProfileState.profileUpdated() = _ProfileUpdated;

//   // State for password change success
//   const factory ProfileState.passwordChanged() = _PasswordChanged;

//   // State for adding payment method success
//   const factory ProfileState.paymentMethodAdded() = _PaymentMethodAdded;

//   // State for failure with error message
//   const factory ProfileState.error({required String message}) = _Error;
// }
