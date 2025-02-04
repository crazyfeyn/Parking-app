// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_application/core/config/local_config.dart';

class ProfileLocalDataSources {
  LocalConfig localConfig;
  ProfileLocalDataSources({
    required this.localConfig,
  });

  Future<void> saveId(int id) async {
    return localConfig.saveUserIdToken(id);
  }

  Future<void> getId() {
    return localConfig.getUserIdToken();
  }
}
