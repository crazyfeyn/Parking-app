// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_application/features/auth/domain/repositories/auth_repositories.dart';

class StartRefreshUsecase {
  AuthRepositories authRepositories;
  StartRefreshUsecase({
    required this.authRepositories,
  });
  @override
  // ignore: override_on_non_overriding_member
  Future<void> call() {
    return authRepositories.startTimer();
  }
}
