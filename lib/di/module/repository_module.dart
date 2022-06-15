
import 'package:floor/floor.dart';

import '../../data/db/asset_dao.dart';
import '../../data/db/database.dart';
import '../../repositories/asset_repository.dart';
import '../../repositories/user_repository.dart';
import '../injection/injection.dart';

class RepositoryModule extends DIModule {
  @override
  Future<void> provides() async {
    final migration1to2 = Migration(1, 2, (database) async {
      await database.execute('ALTER TABLE asset MODIFY COLUMN profitPercent REAL');
    });

    AssetDatabase? assetDb = await $FloorAssetDatabase.databaseBuilder('asset_database.db').addMigrations([migration1to2]).build();
    AssetDao assetDao = assetDb.assetDao;

    getIt.registerSingleton(AssetRepository(assetDao: assetDao));

    getIt.registerSingleton(UserRepository());
  }
}
