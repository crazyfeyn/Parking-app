part of 'profile_bloc.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.getProfile() = _getProfile;
  const factory ProfileEvent.updateProfile({
   required String name,
  required  String surname,
   required String email,
  }) = _updateProfile;
  const factory ProfileEvent.changePassword({
    required String currentPassword,
    required String newPassword,
  }) = _changePassword;
  const factory ProfileEvent.addPaymentMethod({
    required Map<String, dynamic> paymentMethod,
  }) = _addPaymentMethod;
}