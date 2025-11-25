import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pocketly/main.dart';

/// Provider global pour SharedPreferences (utilise l'instance globale initialisée dans main.dart)
///
/// IMPORTANT: Ce provider doit être utilisé partout dans l'application
/// au lieu de créer des instances locales de sharedPreferencesProvider.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  return sharedPreferencesInstance;
});

/// Provider global pour FlutterSecureStorage
///
/// Fournit une instance de FlutterSecureStorage avec des options de sécurité
/// configurées pour iOS et Android.
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );
});
