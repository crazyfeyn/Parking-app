import 'package:flutter_application/features/auth/domain/repositories/auth_repositories.dart';

class AuthicatedUsecase {
   AuthRepositories authRepositories;
  AuthicatedUsecase({
    required this.authRepositories,
  });
  Future<bool> call(void params) {
    return authRepositories.authoricated();
  }
}