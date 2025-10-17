import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pocketly/features/user/domain/entities/user_entity.dart';
import 'package:pocketly/features/user/domain/repositories/user_repository.dart';
import 'package:pocketly/features/user/data/repositories/user_repository_impl.dart';

/// Provider pour l'instance Supabase
final supabaseProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

/// Provider pour le repository utilisateur
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final supabase = ref.watch(supabaseProvider);
  return UserRepositoryImpl(supabase);
});

/// Provider pour l'utilisateur actuel (stream)
final currentUserProvider = StreamProvider<UserEntity?>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return userRepository.watchCurrentUser();
});

/// Provider pour récupérer l'utilisateur actuel (future)
final getUserProvider = FutureProvider<UserEntity?>((ref) async {
  final userRepository = ref.watch(userRepositoryProvider);
  return await userRepository.getCurrentUser();
});

/// Provider pour vérifier si l'utilisateur a accès au premium
final canAccessPremiumProvider = Provider<bool>((ref) {
  final userAsync = ref.watch(currentUserProvider);
  return userAsync.when(
    data: (user) => user?.canAccessPremium ?? false,
    loading: () => false,
    error: (_, _) => false,
  );
});

/// Provider pour vérifier si l'utilisateur est en période d'essai
final isTrialActiveProvider = Provider<bool>((ref) {
  final userAsync = ref.watch(currentUserProvider);
  return userAsync.when(
    data: (user) => user?.isTrialActive ?? false,
    loading: () => false,
    error: (_, _) => false,
  );
});

/// Provider pour obtenir le statut de l'utilisateur (free/trial/premium)
final userStatusProvider = Provider<String>((ref) {
  final userAsync = ref.watch(currentUserProvider);
  return userAsync.when(
    data: (user) => user?.status ?? 'free',
    loading: () => 'loading',
    error: (_, _) => 'error',
  );
});

/// Provider pour les jours restants du trial
final trialDaysLeftProvider = Provider<int>((ref) {
  final userAsync = ref.watch(currentUserProvider);
  return userAsync.when(
    data: (user) => user?.trialDaysLeft ?? 0,
    loading: () => 0,
    error: (_, _) => 0,
  );
});

/// Provider pour vérifier si l'onboarding est complété
final hasCompletedOnboardingProvider = Provider<bool>((ref) {
  final userAsync = ref.watch(currentUserProvider);
  return userAsync.when(
    data: (user) => user?.hasCompletedOnboarding ?? false,
    loading: () => false,
    error: (_, _) => false,
  );
});

// Les actions utilisateur sont déjà gérées par le UserRepository
// Ce fichier contient uniquement les providers de lecture

