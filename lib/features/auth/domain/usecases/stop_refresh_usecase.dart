// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_application/features/auth/domain/repositories/auth_repositories.dart';

class StopRefreshUsecase {
  AuthRepositories authRepositories;
  StopRefreshUsecase({
    required this.authRepositories,
  });
  Future<void> call() {
    return authRepositories.stopToken();
  }
}
