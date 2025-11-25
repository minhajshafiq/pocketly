import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_rate_limiter.g.dart';

/// Service de rate limiting pour les tentatives d'authentification.
///
/// Protège contre les attaques par force brute en limitant le nombre
/// de tentatives de connexion par identifiant (email).
///
/// Configuration:
/// - Maximum 5 tentatives par période
/// - Période de verrouillage: 15 minutes
class AuthRateLimiter {
  AuthRateLimiter({
    this.maxAttempts = 5,
    this.lockoutDuration = const Duration(minutes: 15),
  });

  /// Nombre maximum de tentatives autorisées
  final int maxAttempts;

  /// Durée du verrouillage après dépassement du nombre de tentatives
  final Duration lockoutDuration;

  /// Historique des tentatives par identifiant (email)
  final Map<String, List<DateTime>> _attemptHistory = {};

  /// Vérifie si une tentative est autorisée pour cet identifiant
  ///
  /// Retourne `true` si la tentative est autorisée.
  /// Retourne `false` si l'identifiant est verrouillé (trop de tentatives).
  bool canAttempt(String identifier) {
    final now = DateTime.now();
    final attempts = _attemptHistory[identifier] ?? [];

    // Nettoyer les tentatives expirées (plus vieilles que lockoutDuration)
    final recentAttempts = attempts
        .where((attempt) => now.difference(attempt) < lockoutDuration)
        .toList();

    // Si trop de tentatives récentes, refuser
    if (recentAttempts.length >= maxAttempts) {
      if (kDebugMode) {
        debugPrint(
          '[AuthRateLimiter] Too many attempts for $identifier. '
          'Locked until ${recentAttempts.first.add(lockoutDuration)}',
        );
      }
      return false;
    }

    return true;
  }

  /// Enregistre une tentative pour cet identifiant
  ///
  /// Doit être appelé APRÈS chaque tentative de connexion,
  /// qu'elle réussisse ou échoue.
  void recordAttempt(String identifier) {
    final now = DateTime.now();
    final attempts = _attemptHistory[identifier] ?? [];

    // Ajouter la nouvelle tentative
    attempts.add(now);

    // Nettoyer les vieilles tentatives pour économiser la mémoire
    final recentAttempts = attempts
        .where((attempt) => now.difference(attempt) < lockoutDuration)
        .toList();

    _attemptHistory[identifier] = recentAttempts;

    if (kDebugMode) {
      debugPrint(
        '[AuthRateLimiter] Attempt recorded for $identifier. '
        'Total recent attempts: ${recentAttempts.length}/$maxAttempts',
      );
    }
  }

  /// Réinitialise le compteur pour cet identifiant
  ///
  /// Utile après une connexion réussie pour réinitialiser le compteur.
  void reset(String identifier) {
    _attemptHistory.remove(identifier);
    if (kDebugMode) {
      debugPrint('[AuthRateLimiter] Reset counter for $identifier');
    }
  }

  /// Récupère le nombre de tentatives restantes pour cet identifiant
  int remainingAttempts(String identifier) {
    final now = DateTime.now();
    final attempts = _attemptHistory[identifier] ?? [];

    final recentAttempts = attempts
        .where((attempt) => now.difference(attempt) < lockoutDuration)
        .length;

    return (maxAttempts - recentAttempts).clamp(0, maxAttempts);
  }

  /// Récupère le temps restant avant déverrouillage (si verrouillé)
  Duration? timeUntilUnlock(String identifier) {
    if (canAttempt(identifier)) return null;

    final now = DateTime.now();
    final attempts = _attemptHistory[identifier] ?? [];

    if (attempts.isEmpty) return null;

    // Le temps de déverrouillage est basé sur la première tentative
    final oldestAttempt = attempts.first;
    final unlockTime = oldestAttempt.add(lockoutDuration);

    return unlockTime.difference(now);
  }
}

/// Provider pour le service de rate limiting
@riverpod
AuthRateLimiter authRateLimiter(Ref ref) {
  return AuthRateLimiter();
}
