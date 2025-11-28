import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/features/user/user.dart';

import '../../domain/entities/auth_state.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import '../../domain/usecases/get_current_session_usecase.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../../domain/usecases/update_password_usecase.dart';
import '../../domain/usecases/update_email_usecase.dart';
import '../../domain/usecases/is_authenticated_usecase.dart';
import '../../domain/usecases/get_current_user_id_usecase.dart';
import '../../domain/usecases/watch_auth_state_usecase.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/datasources/auth_remote_datasource_impl.dart';

part 'auth_providers.g.dart';

/// Provider pour le datasource remote
@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  final supabase = SupabaseConfig.client;
  return AuthRemoteDataSourceImpl(supabase);
}

/// Provider pour le repository auth
@riverpod
class AuthRepositoryProvider extends _$AuthRepositoryProvider {
  @override
  AuthRepository build() {
    final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
    return AuthRepositoryImpl(remoteDataSource);
  }
}

/// Provider pour le use case signIn
@riverpod
SignInUseCase signInUseCase(Ref ref) {
  final repository = ref.watch(authRepositoryProviderProvider);
  return SignInUseCase(repository);
}

/// Provider pour le use case signUp
@riverpod
SignUpUseCase signUpUseCase(Ref ref) {
  final repository = ref.watch(authRepositoryProviderProvider);
  return SignUpUseCase(repository);
}

/// Provider pour le use case signOut
@riverpod
SignOutUseCase signOutUseCase(Ref ref) {
  final repository = ref.watch(authRepositoryProviderProvider);
  return SignOutUseCase(repository);
}

/// Provider pour le use case getCurrentSession
@riverpod
GetCurrentSessionUseCase getCurrentSessionUseCase(Ref ref) {
  final repository = ref.watch(authRepositoryProviderProvider);
  return GetCurrentSessionUseCase(repository);
}

/// Provider pour le use case resetPassword
@riverpod
ResetPasswordUseCase resetPasswordUseCase(Ref ref) {
  final repository = ref.watch(authRepositoryProviderProvider);
  return ResetPasswordUseCase(repository);
}

/// Provider pour le use case updatePassword
@riverpod
UpdatePasswordUseCase updatePasswordUseCase(Ref ref) {
  final repository = ref.watch(authRepositoryProviderProvider);
  return UpdatePasswordUseCase(repository);
}

/// Provider pour le use case updateEmail
@riverpod
UpdateEmailUseCase updateEmailUseCase(Ref ref) {
  final repository = ref.watch(authRepositoryProviderProvider);
  return UpdateEmailUseCase(repository);
}

/// Provider pour le use case isAuthenticated
@riverpod
IsAuthenticatedUseCase isAuthenticatedUseCase(Ref ref) {
  final repository = ref.watch(authRepositoryProviderProvider);
  return IsAuthenticatedUseCase(repository);
}

/// Provider pour le use case getCurrentUserId
@riverpod
GetCurrentUserIdUseCase getCurrentUserIdUseCase(Ref ref) {
  final repository = ref.watch(authRepositoryProviderProvider);
  return GetCurrentUserIdUseCase(repository);
}

/// Provider pour le use case watchAuthState
@riverpod
WatchAuthStateUseCase watchAuthStateUseCase(Ref ref) {
  final repository = ref.watch(authRepositoryProviderProvider);
  return WatchAuthStateUseCase(repository);
}

/// Notifier pour gérer l'état d'authentification
@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<AuthState> build() async {
    // Écouter les changements d'état d'authentification
    final repository = ref.watch(authRepositoryProviderProvider);

    // Vérifier la session actuelle au démarrage
    try {
      final session = await repository.getCurrentSession();
      if (session != null && !session.isExpired) {
        return AuthState.authenticated(session);
      }
      return const AuthState.unauthenticated();
    } catch (e) {
      ref.read(loggerProvider).e('Error loading auth state', error: e);
      return const AuthState.unauthenticated();
    }
  }

  /// Se connecter avec email et mot de passe
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final signInUseCase = ref.read(signInUseCaseProvider);
      final session = await signInUseCase(email: email, password: password);

      // Créer le profil utilisateur si nécessaire
      await _syncUserProfile(session);

      // Note: La synchronisation des catégories se fait maintenant automatiquement
      // lors de la première récupération (Cache-First strategy)

      return AuthState.authenticated(session);
    });
  }

  /// S'inscrire avec email et mot de passe
  Future<void> signUp({
    required String email,
    required String password,
    String? name,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final signUpUseCase = ref.read(signUpUseCaseProvider);
      final session = await signUpUseCase(
        email: email,
        password: password,
        name: name,
      );

      // Créer le profil utilisateur
      await _createUserProfile(session, name);

      // Note: La synchronisation des catégories se fait maintenant automatiquement
      // lors de la première récupération (Cache-First strategy)

      return AuthState.authenticated(session);
    });
  }

  /// Se déconnecter
  Future<void> signOut() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // Récupérer l'ID utilisateur avant la déconnexion pour nettoyer les données locales
      String? userId;
      try {
        final currentUserAsync = ref.read(currentUserProvider);
        currentUserAsync.when(
          data: (user) => userId = user?.id,
          loading: () => userId = null,
          error: (_, _) => userId = null,
        );
      } catch (e) {
        // Ignorer si l'utilisateur n'est pas disponible
        userId = null;
      }

      final signOutUseCase = ref.read(signOutUseCaseProvider);
      await signOutUseCase();

      // Nettoyer toutes les données locales
      try {
        final localDataService = LocalDataService(ref);
        await localDataService.clearAllLocalData(userId: userId);
      } catch (e) {
        // Logger l'erreur mais continuer la déconnexion
        ref.read(loggerProvider).w('Erreur lors du nettoyage des données locales: $e');
      }

      // Invalider le provider user
      ref.invalidate(currentUserProvider);

      return const AuthState.unauthenticated();
    });
  }

  /// Réinitialiser le mot de passe
  Future<void> resetPassword(String email) async {
    final resetPasswordUseCase = ref.read(resetPasswordUseCaseProvider);
    await resetPasswordUseCase(email);
  }

  /// Mettre à jour le mot de passe
  Future<void> updatePassword(String newPassword) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final updatePasswordUseCase = ref.read(updatePasswordUseCaseProvider);
      await updatePasswordUseCase(newPassword);

      // Retourner l'état actuel après succès
      return state.value ?? const AuthState.unauthenticated();
    });
  }

  /// Mettre à jour l'email
  Future<void> updateEmail(String newEmail) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final updateEmailUseCase = ref.read(updateEmailUseCaseProvider);
      await updateEmailUseCase(newEmail);

      // Retourner l'état actuel après succès
      return state.value ?? const AuthState.unauthenticated();
    });
  }

  /// Créer le profil utilisateur après inscription
  Future<void> _createUserProfile(AuthSession session, String? name) async {
    try {
      ref.read(loggerProvider).d('🔵 [Auth] Création du profil utilisateur avec TRIAL pour: ${session.user.email}');

      final createUserUseCase = await ref.read(createUserUseCaseProvider.future);

      // Créer l'utilisateur avec un trial de 14 jours automatique
      final userEntity = UserEntityFactories.withTrial(
        id: session.user.id,
        email: session.user.email,
        name: name,
      );

      ref.read(loggerProvider).d('🔵 [Auth] Trial configuré: ${userEntity.premiumTrialStart} → ${userEntity.premiumTrialEnd}');
      ref.read(loggerProvider).d('🔵 [Auth] Appel du use case de création...');

      await createUserUseCase(userEntity);

      ref.read(loggerProvider).i('✅ [Auth] Profil utilisateur créé avec succès avec trial de 14 jours');

      // Rafraîchir le provider user
      ref.invalidate(currentUserProvider);

      ref.read(loggerProvider).i('✅ [Auth] currentUserProvider invalidé, il va se recharger');
    } catch (e, stackTrace) {
      ref.read(loggerProvider).e('❌ [Auth] Erreur lors de la création du profil', error: e, stackTrace: stackTrace);
      // Ne pas échouer l'authentification si la création du profil échoue
    }
  }

  /// Synchroniser le profil utilisateur après connexion
  Future<void> _syncUserProfile(AuthSession session) async {
    try {
      // Rafraîchir le provider user pour charger le profil
      ref.invalidate(currentUserProvider);

      // Vérifier si le profil existe
      final user = await ref.read(currentUserProvider.future);

      // Si le profil n'existe pas, le créer
      if (user == null) {
        await _createUserProfile(session, null);
      }
    } catch (e) {
      ref.read(loggerProvider).e('Error syncing user profile', error: e);
      // Ne pas échouer l'authentification si la sync échoue
    }
  }

  /// Rafraîchir la session
  Future<void> refreshSession() async {
    final currentState = state.value;
    if (currentState is! AuthAuthenticated) return;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProviderProvider);
      final newSession = await repository.refreshSession(
        currentState.session.refreshToken,
      );
      return AuthState.authenticated(newSession);
    });
  }

  /// Connexion avec Google (TODO: Implémenter)
  Future<void> signInWithGoogle() async {
    // TODO: Implémenter la connexion Google
    throw UnimplementedError('Google Sign-In not implemented yet');
  }

  /// Connexion avec Apple (TODO: Implémenter)
  Future<void> signInWithApple() async {
    // TODO: Implémenter la connexion Apple
    throw UnimplementedError('Apple Sign-In not implemented yet');
  }

}

/// Provider pour vérifier si l'utilisateur est authentifié
@riverpod
bool isAuthenticated(Ref ref) {
    final authState = ref.watch(authProvider);
    return authState.when(
      data: (state) => state is AuthAuthenticated,
      loading: () => false,
      error: (_, _) => false,
    );
}

/// Provider pour obtenir la session actuelle
@riverpod
AuthSession? currentSession(Ref ref) {
    final authState = ref.watch(authProvider);
    return authState.when(
      data: (state) => state is AuthAuthenticated ? state.session : null,
      loading: () => null,
      error: (_, _) => null,
    );
  }

/// Provider pour obtenir l'ID utilisateur actuel
@riverpod
String? currentUserId(Ref ref) {
  final session = ref.watch(currentSessionProvider);
  return session?.user.id;
}
