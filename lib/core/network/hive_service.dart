import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../config/constants/hive_table.dart';
import '../../features/auth/data/model/auth_hive_model.dart';

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

  Future<void> deleteStaff(String staffId) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.staffBox);
    await box.delete(staffId);
  }

  // Delete hive
  Future<void> deleteHive() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.staffBox);
  }
}
