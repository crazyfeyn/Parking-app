// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_application/core/config/local_config.dart';
import 'package:flutter_application/core/error/failure.dart';

class LocalAuthDatasources {
  LocalConfig localConfig;
  LocalAuthDatasources({
    required this.localConfig,
  });

  Future<void> saveToken(String token) async {
    await localConfig.saveToken(token);
  }

  Future<String> getToken() async {
    final recponce = await localConfig.getToken();
    if (recponce.isNotEmpty) {
      return recponce;
    }
    throw CacheFailure();
  }

  Future<void> saveRefreshToken(String token) async {
    await localConfig.saveRefreshToken(token);
  }

  Future<String> getRefreshToken() async {
    final recponce = await localConfig.getRefreshToken();
    if (recponce.isNotEmpty) {
      return recponce;
    }
    throw CacheFailure();
  }
}
