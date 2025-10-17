import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/errors/errors.dart';
import 'package:pocketly/features/notifications/data/datasources/notification_local_datasource.dart';
import 'package:pocketly/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:pocketly/features/notifications/domain/entities/notification_entity.dart';
import 'package:pocketly/features/notifications/domain/repositories/notification_repository.dart';
import 'package:pocketly/features/notifications/domain/usecases/notification_service.dart';

// ==================== INFRASTRUCTURE PROVIDERS ====================

/// Provider pour FlutterLocalNotificationsPlugin
final flutterLocalNotificationsPluginProvider = Provider<FlutterLocalNotificationsPlugin>((ref) {
  return FlutterLocalNotificationsPlugin();
});

/// Provider pour NotificationLocalDataSource
final notificationLocalDataSourceProvider = Provider<NotificationLocalDataSource>((ref) {
  return NotificationLocalDataSource(
    flutterLocalNotificationsPlugin: ref.watch(flutterLocalNotificationsPluginProvider),
  );
});

/// Provider pour NotificationRepository
final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepositoryImpl(
    localDataSource: ref.watch(notificationLocalDataSourceProvider),
  );
});

// ==================== USE CASE PROVIDERS ====================

/// Provider pour le service de notification consolidé
final notificationServiceUseCaseProvider = Provider<NotificationService>((ref) {
  return NotificationService(ref.watch(notificationRepositoryProvider));
});

// ==================== STATE PROVIDERS ====================

/// Provider pour l'état des permissions de notification
final notificationPermissionStateProvider = FutureProvider<bool>((ref) async {
  final notificationService = ref.read(notificationServiceUseCaseProvider);
  return await notificationService.checkPermissions();
});

// ==================== NOTIFICATION SERVICE ====================

/// État du service de notification
class NotificationServiceState {
  final bool isInitialized;
  final String? error;

  const NotificationServiceState({
    this.isInitialized = false,
    this.error,
  });

  NotificationServiceState copyWith({
    bool? isInitialized,
    String? error,
  }) {
    return NotificationServiceState(
      isInitialized: isInitialized ?? this.isInitialized,
      error: error,
    );
  }
}

/// Contrôleur pour le service de notification
class NotificationServiceController {
  final Ref ref;
  NotificationServiceState _state = const NotificationServiceState();

  NotificationServiceController(this.ref) {
    _initialize();
  }

  NotificationServiceState get state => _state;

  /// Initialiser le service de notification
  Future<void> _initialize() async {
    try {
      final dataSource = ref.read(notificationLocalDataSourceProvider);
      await dataSource.initialize();
      _state = _state.copyWith(isInitialized: true);
    } catch (e, stackTrace) {
      debugPrint('Error initializing notification service: $e');
      _state = _state.copyWith(error: e.toString());
      
      // Utiliser le système d'erreur global
      ref.read(errorNotifierProvider.notifier).setError(
        NotificationError(
          operation: 'initialize',
          technicalMessage: 'Failed to initialize notification service: $e',
          originalError: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  /// Demander les permissions de notification
  Future<bool> requestPermissions() async {
    try {
      final notificationService = ref.read(notificationServiceUseCaseProvider);
      return await notificationService.requestPermissions();
    } catch (e, stackTrace) {
      // Utiliser le système d'erreur global
      ref.read(errorNotifierProvider.notifier).setError(e, stackTrace);
      return false;
    }
  }

  /// Planifier une notification
  Future<bool> scheduleNotification(NotificationEntity notification) async {
    try {
      final notificationService = ref.read(notificationServiceUseCaseProvider);
      return await notificationService.scheduleNotification(notification);
    } catch (e, stackTrace) {
      // Utiliser le système d'erreur global
      ref.read(errorNotifierProvider.notifier).setError(e, stackTrace);
      return false;
    }
  }

  /// Afficher une notification immédiate
  Future<bool> showNotification(NotificationEntity notification) async {
    try {
      final notificationService = ref.read(notificationServiceUseCaseProvider);
      return await notificationService.showNotification(notification);
    } catch (e, stackTrace) {
      // Utiliser le système d'erreur global
      ref.read(errorNotifierProvider.notifier).setError(e, stackTrace);
      return false;
    }
  }

  /// Annuler une notification spécifique par ID
  Future<bool> cancelNotification(int id) async {
    try {
      final notificationService = ref.read(notificationServiceUseCaseProvider);
      return await notificationService.cancelNotification(id);
    } catch (e, stackTrace) {
      // Utiliser le système d'erreur global
      ref.read(errorNotifierProvider.notifier).setError(e, stackTrace);
      return false;
    }
  }

  /// Annuler toutes les notifications planifiées
  Future<bool> cancelAllNotifications() async {
    try {
      final notificationService = ref.read(notificationServiceUseCaseProvider);
      return await notificationService.cancelAllNotifications();
    } catch (e, stackTrace) {
      // Utiliser le système d'erreur global
      ref.read(errorNotifierProvider.notifier).setError(e, stackTrace);
      return false;
    }
  }

  /// Obtenir le fuseau horaire de l'appareil
  Future<String> getDeviceTimeZone() async {
    try {
      final notificationService = ref.read(notificationServiceUseCaseProvider);
      return await notificationService.getDeviceTimeZone();
    } catch (e, stackTrace) {
      // Utiliser le système d'erreur global
      ref.read(errorNotifierProvider.notifier).setError(e, stackTrace);
      // Retourner une valeur par défaut
      return 'UTC';
    }
  }
}

/// Provider pour le service de notification
final notificationServiceProvider = Provider<NotificationServiceController>((ref) {
  return NotificationServiceController(ref);
});

/// Provider pour l'initialisation du service de notification
/// Utilisé dans main.dart pour initialiser le service au démarrage de l'application
final notificationServiceInitProvider = FutureProvider<void>((ref) async {
  // Attendre que le service soit initialisé
  final service = ref.watch(notificationServiceProvider);
  
  if (!service.state.isInitialized) {
    // Attendre un peu pour laisser le temps à l'initialisation de se terminer
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Vérifier à nouveau l'état
    final updatedService = ref.read(notificationServiceProvider);
    if (!updatedService.state.isInitialized && updatedService.state.error != null) {
      throw Exception('Failed to initialize notification service: ${updatedService.state.error}');
    }
  }
});