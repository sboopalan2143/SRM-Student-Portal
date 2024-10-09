import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sample/home/drawer_pages/profile/model/profile_hive_model.dart';

class HiveRepository {
  static bool initialized = false;

  static void initializeHiveFlag() => initialized = !initialized;

  static Future<void> initializeHive() async {
    if (!initialized) {
      final storePath = await getApplicationDocumentsDirectory();
      final directory = Directory(storePath.path);
      Hive..init(directory.path)
      ..registerAdapter(ProfileHiveDataAdapter());
      // ..registerAdapter(ProductCategoryDataAdapter())
      // ..registerAdapter(CompanySettingDataAdapter())
      // ..registerAdapter(ThemeSettingDataAdapter())
      // ..registerAdapter(ExpensesCategoriesDataAdapter())
      // ..registerAdapter(UOMAdapter())
      // ..registerAdapter(CurrencyMasterDataAdapter())
      // ..registerAdapter(TimeZoneDataAdapter())
      // ..registerAdapter(RoleResourceDataAdapter())
      // ..registerAdapter(UserResourceDataAdapter())
      // ..registerAdapter(CustomerAdapter())
      // ..registerAdapter(SaleAdapter())
      // ..registerAdapter(PosSettingDataAdapter());
      initializeHiveFlag();
    }
  }
}
