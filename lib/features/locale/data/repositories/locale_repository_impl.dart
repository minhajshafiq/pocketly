import 'package:pocketly/features/locale/data/datasources/locale_local_datasource.dart';
import 'package:pocketly/features/locale/domain/repositories/locale_repository.dart';

/// Implementation du repository de locale
class LocaleRepositoryImpl implements LocaleRepository {
  LocaleRepositoryImpl(this._localDataSource);

  final LocaleLocalDataSource _localDataSource;

  @override
  Future<String?> getCurrentLocale() async {
    try {
      return await _localDataSource.getLocale();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> setLocale(String languageCode) async {
    await _localDataSource.saveLocale(languageCode);
  }

  @override
  Future<void> clearLocale() async {
    await _localDataSource.clearLocale();
  }
}
