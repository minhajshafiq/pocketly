import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pocketly/features/user/domain/entities/user_entity.dart';
import 'package:pocketly/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:pocketly/features/auth/domain/repositories/auth_repository.dart';

// ==================== REPOSITORIES ====================

/// Provider pour Supabase client
final supabaseProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

/// Provider pour AuthRepository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final supabase = ref.watch(supabaseProvider);
  return AuthRepositoryImpl(supabase);
});

// ==================== AUTH STATE PROVIDER ====================

/// Provider principal pour l'état d'authentification
/// 
/// Utilisation :
/// ```dart
/// final authState = ref.watch(authStateProvider);
/// authState.when(
///   data: (user) => user != null ? HomeScreen() : LoginScreen(),
///   loading: () => LoadingScreen(),
///   error: (err, _) => ErrorScreen(),
/// );
/// ```
final authStateProvider = StreamProvider<UserEntity?>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  
  // Créer un stream qui combine le stream Supabase et l'état initial
  return repository.watchAuthState();
});

// ==================== AUTH ACTIONS ====================

/// Provider pour les actions d'authentification
/// 
/// Utilisation :
/// ```dart
/// await ref.read(authActionsProvider).signInWithGoogle();
/// await ref.read(authActionsProvider).signInWithApple();
/// await ref.read(authActionsProvider).signOut();
/// ```
final authActionsProvider = Provider<AuthActions>((ref) {
  return AuthActions(ref);
});

class AuthActions {
  final Ref _ref;
  
  AuthActions(this._ref);
  
  AuthRepository get _repository => _ref.read(authRepositoryProvider);

  /// Connexion avec Google OAuth
  Future<UserEntity> signInWithGoogle() async {
    try {
      final user = await _repository.signInWithGoogle();
      // Le stream authStateProvider sera automatiquement mis à jour
      return user;
    } catch (e) {
      rethrow;
    }
  }

  /// Connexion avec Apple OAuth
  Future<UserEntity> signInWithApple() async {
    try {
      final user = await _repository.signInWithApple();
      // Le stream authStateProvider sera automatiquement mis à jour
      return user;
    } catch (e) {
      rethrow;
    }
  }

  /// Connexion avec email/password
  Future<UserEntity> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _repository.signInWithEmailPassword(
        email: email,
        password: password,
      );
      return user;
    } catch (e) {
      rethrow;
    }
  }

  /// Inscription avec email/password
  Future<UserEntity> signUpWithEmailPassword({
    required String email,
    required String password,
    String? name,
  }) async {
    try {
      final user = await _repository.signUpWithEmailPassword(
        email: email,
        password: password,
        name: name,
      );
      return user;
    } catch (e) {
      rethrow;
    }
  }

  /// Déconnexion
  Future<void> signOut() async {
    try {
      await _repository.signOut();
      // Le stream authStateProvider sera automatiquement mis à jour
    } catch (e) {
      rethrow;
    }
  }

  /// Rafraîchir la session
  Future<UserEntity?> refreshSession() async {
    try {
      return await _repository.restoreSession();
    } catch (e) {
      rethrow;
    }
  }

  /// Obtenir l'utilisateur actuel
  Future<UserEntity?> getCurrentUser() async {
    try {
      return await _repository.getCurrentUser();
    } catch (e) {
      rethrow;
    }
  }

  /// Rafraîchir les données utilisateur
  Future<UserEntity?> refreshCurrentUser() async {
    try {
      return await _repository.refreshCurrentUser();
    } catch (e) {
      rethrow;
    }
  }

  /// Envoyer un email de réinitialisation de mot de passe
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _repository.sendPasswordResetEmail(email);
    } catch (e) {
      rethrow;
    }
  }
}

// ==================== COMPUTED PROVIDERS ====================

/// Provider qui retourne true si l'utilisateur est authentifié
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.maybeWhen(
    data: (user) => user != null,
    orElse: () => false,
  );
});

/// Provider qui retourne l'utilisateur actuel (null si non connecté)
final currentUserProvider = Provider<UserEntity?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.maybeWhen(
    data: (user) => user,
    orElse: () => null,
  );
});

/// Provider qui retourne true si l'utilisateur est Premium
final isPremiumProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  return user?.isPremium ?? false;
});

/// Provider qui retourne true si l'utilisateur a un trial actif
final hasActiveTrialProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return false;
  return user.isTrialActive;
});

/// Provider qui retourne true si l'utilisateur peut accéder au premium
final canAccessPremiumProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return false;
  return user.canAccessPremium;
});

/// Provider qui retourne le statut de l'utilisateur (premium, trial, free)
final userStatusProvider = Provider<String>((ref) {
  final user = ref.watch(currentUserProvider);
  return user?.status ?? 'free';
});

/// Provider qui retourne true si l'onboarding est complété
final hasCompletedOnboardingProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  return user?.hasCompletedOnboarding ?? false;
});

/// Provider qui retourne le nombre de jours restants du trial
final trialDaysLeftProvider = Provider<int>((ref) {
  final user = ref.watch(currentUserProvider);
  return user?.trialDaysLeft ?? 0;
});

// ==================== HELPER EXTENSIONS ====================

/// Extension pour faciliter l'utilisation dans les widgets
extension AuthStateRef on WidgetRef {
  /// Récupère l'utilisateur actuel
  UserEntity? get currentUser => read(currentUserProvider);
  
  /// Vérifie si l'utilisateur est connecté
  bool get isAuthenticated => read(isAuthenticatedProvider);
  
  /// Vérifie si l'utilisateur est premium
  bool get isPremium => read(isPremiumProvider);
  
  /// Vérifie si l'utilisateur a un trial actif
  bool get hasActiveTrial => read(hasActiveTrialProvider);
  
  /// Vérifie si l'utilisateur peut accéder au premium
  bool get canAccessPremium => read(canAccessPremiumProvider);
  
  /// Récupère le statut de l'utilisateur
  String get userStatus => read(userStatusProvider);
  
  /// Actions d'authentification
  AuthActions get authActions => read(authActionsProvider);
}

