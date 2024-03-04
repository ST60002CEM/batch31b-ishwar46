import 'package:age_care/features/profile/data/model/profile_hive_model.dart';
import 'package:age_care/features/profile/domain/entity/profile_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../../config/constants/hive_table.dart';
import '../../../features/auth/data/model/auth_hive_model.dart';

// Create object using a provider
final hiveServiceProvider = Provider<HiveService>(
  (ref) => HiveService(),
);

class HiveService {
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    // Register Adapters
    Hive.registerAdapter(AuthHiveModelAdapter());
  }

  // ======================== Auth Queries ========================

  Future<void> registerStaff(AuthHiveModel auth) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.staffBox);
    await box.put(auth.staffId, auth);
  }

  // Login
  Future<AuthHiveModel?> loginStaff(String username, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.staffBox);
    var auths = box.values.toList();
    var auth = auths.firstWhere(
      (element) => element.username == username && element.password == password,
      orElse: () => AuthHiveModel.empty(),
    );
    return auth;
  }

  Future<List<AuthHiveModel>> getAllStaff() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.staffBox);
    var auths = box.values.toList();
    return auths;
  }

  // ======================== Profile Queries ========================

  Future<List<ProfileHiveModel>> getProfile() async {
    var box =
        await Hive.openBox<ProfileHiveModel>(HiveTableConstant.profileBox);
    var profile = box.values.toList();
    box.close();
    return profile;
  }

  // Delete hive
  Future<void> deleteHive() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.staffBox);
  }
}
