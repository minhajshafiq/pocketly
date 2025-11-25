import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:pocketly/core/config/logo_dev_config.dart';
import 'package:pocketly/core/errors/common_errors.dart';
import 'package:pocketly/core/services/logger_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logo_dev_service.g.dart';

/// Modèle pour un résultat de recherche de logo
class LogoSearchResult {
  final String name;
  final String domain;
  final String? brandId;
  final String? industry;

  const LogoSearchResult({
    required this.name,
    required this.domain,
    this.brandId,
    this.industry,
  });

  factory LogoSearchResult.fromJson(Map<String, dynamic> json) {
    return LogoSearchResult(
      name: json['name'] as String? ?? '',
      domain: json['domain'] as String? ?? '',
      brandId: json['brand_id'] as String?,
      industry: json['industry'] as String?,
    );
  }

  /// Construit l'URL de l'image du logo
  String getImageUrl({int size = 200, String format = 'png'}) {
    return '${LogoDevConfig.imageBaseUrl}/$domain?size=$size&format=$format&token=${LogoDevConfig.imageToken}';
  }
}

/// Service pour récupérer les logos de marques via logo.dev API.
///
/// Utilise l'API logo.dev pour obtenir des logos de haute qualité
/// pour les transactions (ex: Apple, Amazon, Netflix, etc.)
class LogoDevService {
  final LoggerService _logger;

  const LogoDevService(this._logger);

  /// Recherche des logos par nom de marque ou domaine.
  ///
  /// [query] - Le terme de recherche (nom de marque ou domaine)
  ///
  /// Retourne une liste de résultats de recherche
  Future<List<LogoSearchResult>> searchLogos(String query) async {
    try {
      if (query.trim().isEmpty) {
        return [];
      }

      _logger.d('🔍 [LogoDev] Searching logos for: $query');

      // Nettoie la query
      final cleanQuery = query.trim();

      // Construit l'URL de recherche
      final url = Uri.parse(
        '${LogoDevConfig.searchApiUrl}/search?q=$cleanQuery',
      );

      _logger.d('📡 [LogoDev] Search URL: $url');

      // Fait la requête HTTP avec authentification
      final response = await http.get(url, headers: LogoDevConfig.authHeaders);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Parse les résultats
        final results = <LogoSearchResult>[];
        if (data is List) {
          for (final item in data) {
            if (item is Map<String, dynamic>) {
              results.add(LogoSearchResult.fromJson(item));
            }
          }
        } else if (data is Map<String, dynamic> && data['results'] is List) {
          for (final item in data['results']) {
            if (item is Map<String, dynamic>) {
              results.add(LogoSearchResult.fromJson(item));
            }
          }
        }

        _logger.d(
          '✅ [LogoDev] Found ${results.length} logos for "$cleanQuery"',
        );
        return results;
      } else if (response.statusCode == 404 || response.statusCode == 204) {
        _logger.w('⚠️ [LogoDev] No logos found for "$cleanQuery"');
        return [];
      } else {
        _logger.e('❌ [LogoDev] Search failed: ${response.statusCode}');
        throw ServerError(
          statusCode: response.statusCode,
          technicalMessage: 'Failed to search logos: ${response.statusCode}',
        );
      }
    } catch (e, stackTrace) {
      if (e is ServerError) rethrow;

      _logger.e(
        '❌ [LogoDev] Error searching logos',
        error: e,
        stackTrace: stackTrace,
      );
      throw NetworkError(
        technicalMessage: 'Network error while searching logos: $e',
        stackTrace: stackTrace,
      );
    }
  }

  /// Récupère le logo d'une marque par son domaine.
  ///
  /// [domain] - Le domaine de la marque (ex: "apple.com", "amazon.com")
  /// [size] - Taille du logo en pixels (défaut: 200)
  /// [format] - Format de l'image (png, jpg, svg)
  ///
  /// Retourne les bytes de l'image ou null si introuvable.
  Future<Uint8List?> getLogoByDomain({
    required String domain,
    int size = 200,
    String format = 'png',
  }) async {
    try {
      _logger.d('🔍 [LogoDev] Fetching logo for domain: $domain');

      // Nettoie le domaine (enlève https://, www., etc.)
      final cleanDomain = _cleanDomain(domain);

      // Construit l'URL avec le token d'image
      final url = Uri.parse(
        '${LogoDevConfig.imageBaseUrl}/$cleanDomain?size=$size&format=$format&token=${LogoDevConfig.imageToken}',
      );

      _logger.d('📡 [LogoDev] Request URL: $url');

      // Fait la requête HTTP
      final response = await http.get(url);

      if (response.statusCode == 200) {
        _logger.d('✅ [LogoDev] Logo fetched successfully for $cleanDomain');
        return response.bodyBytes;
      } else if (response.statusCode == 404) {
        _logger.w('⚠️ [LogoDev] Logo not found for $cleanDomain');
        return null;
      } else {
        _logger.e('❌ [LogoDev] Failed to fetch logo: ${response.statusCode}');
        throw ServerError(
          statusCode: response.statusCode,
          technicalMessage:
              'Failed to fetch logo from logo.dev: ${response.statusCode}',
        );
      }
    } catch (e, stackTrace) {
      if (e is ServerError) rethrow;

      _logger.e(
        '❌ [LogoDev] Error fetching logo',
        error: e,
        stackTrace: stackTrace,
      );
      throw NetworkError(
        technicalMessage: 'Network error while fetching logo: $e',
        stackTrace: stackTrace,
      );
    }
  }

  /// Recherche et récupère le logo d'une marque par son nom.
  ///
  /// [brandName] - Le nom de la marque (ex: "Apple", "Amazon")
  /// [size] - Taille du logo en pixels
  ///
  /// Cette méthode tente de deviner le domaine à partir du nom de la marque.
  Future<Uint8List?> getLogoByBrandName({
    required String brandName,
    int size = 200,
  }) async {
    try {
      _logger.d('🔍 [LogoDev] Searching logo for brand: $brandName');

      // Tente de construire un domaine à partir du nom de la marque
      // Ex: "Apple" -> "apple.com", "Amazon" -> "amazon.com"
      final guessDomain =
          '${brandName.toLowerCase().trim().replaceAll(' ', '')}.com';

      return await getLogoByDomain(domain: guessDomain, size: size);
    } catch (e, stackTrace) {
      _logger.e(
        '❌ [LogoDev] Error searching logo for brand',
        error: e,
        stackTrace: stackTrace,
      );
      return null; // Retourne null si pas trouvé
    }
  }

  /// Nettoie le domaine pour le format attendu par logo.dev.
  ///
  /// Exemples :
  /// - "https://www.apple.com" -> "apple.com"
  /// - "amazon.fr" -> "amazon.fr"
  /// - "www.netflix.com" -> "netflix.com"
  String _cleanDomain(String domain) {
    String cleaned = domain.trim().toLowerCase();

    // Enlève le protocole
    cleaned = cleaned.replaceAll(RegExp(r'https?://'), '');

    // Enlève www.
    cleaned = cleaned.replaceAll(RegExp(r'^www\.'), '');

    // Enlève le path et les query params
    cleaned = cleaned.split('/').first;
    cleaned = cleaned.split('?').first;

    return cleaned;
  }

  /// Valide si un domaine est valide pour logo.dev.
  bool isValidDomain(String domain) {
    final cleaned = _cleanDomain(domain);
    // Vérifie qu'il y a au moins un point (ex: apple.com)
    return cleaned.contains('.') && cleaned.length > 3;
  }

  /// Suggestions de marques populaires pour l'autocomplete
  static const List<Map<String, String>> popularBrands = [
    {'name': 'Apple', 'domain': 'apple.com'},
    {'name': 'Amazon', 'domain': 'amazon.com'},
    {'name': 'Netflix', 'domain': 'netflix.com'},
    {'name': 'Spotify', 'domain': 'spotify.com'},
    {'name': 'Google', 'domain': 'google.com'},
    {'name': 'Microsoft', 'domain': 'microsoft.com'},
    {'name': 'Facebook', 'domain': 'facebook.com'},
    {'name': 'Instagram', 'domain': 'instagram.com'},
    {'name': 'Uber', 'domain': 'uber.com'},
    {'name': 'Airbnb', 'domain': 'airbnb.com'},
    {'name': 'McDonald\'s', 'domain': 'mcdonalds.com'},
    {'name': 'Starbucks', 'domain': 'starbucks.com'},
    {'name': 'Nike', 'domain': 'nike.com'},
    {'name': 'Adidas', 'domain': 'adidas.com'},
    {'name': 'Zara', 'domain': 'zara.com'},
    {'name': 'H&M', 'domain': 'hm.com'},
    {'name': 'IKEA', 'domain': 'ikea.com'},
    {'name': 'Carrefour', 'domain': 'carrefour.fr'},
    {'name': 'Lidl', 'domain': 'lidl.com'},
    {'name': 'Aldi', 'domain': 'aldi.com'},
  ];
}

/// Provider pour LogoDevService
@riverpod
LogoDevService logoDevService(Ref ref) {
  final logger = ref.watch(loggerProvider);
  return LogoDevService(logger);
}
