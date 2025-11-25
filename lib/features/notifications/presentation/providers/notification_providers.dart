import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pocketly/core/errors/errors.dart';
import 'package:pocketly/features/notifications/data/datasources/notification_local_datasource.dart';
import 'package:pocketly/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:pocketly/features/notifications/domain/entities/notification_entity.dart';
import 'package:pocketly/features/notifications/domain/repositories/notification_repository.dart';
import 'package:pocketly/features/notifications/domain/usecases/notification_service.dart';

part 'notification_providers.g.dart';

// ==================== INFRASTRUCTURE PROVIDERS ====================

/// Provider pour FlutterLocalNotificationsPlugin
@Riverpod(keepAlive: true)
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin(Ref ref) {
  return FlutterLocalNotificationsPlugin();
}

/// Provider pour NotificationLocalDataSource
@Riverpod(keepAlive: true)
NotificationLocalDataSource notificationLocalDataSource(Ref ref) {
  return NotificationLocalDataSource(
    flutterLocalNotificationsPlugin: ref.watch(flutterLocalNotificationsPluginProvider),
  );
}

/// Provider pour NotificationRepository
@Riverpod(keepAlive: true)
NotificationRepository notificationRepository(Ref ref) {
  return NotificationRepositoryImpl(
    localDataSource: ref.watch(notificationLocalDataSourceProvider),
  );
}

// ==================== USE CASE PROVIDERS ====================

/// Provider pour le service de notification consolidé
@Riverpod(keepAlive: true)
NotificationService notificationServiceUseCase(Ref ref) {
  return NotificationService(ref.watch(notificationRepositoryProvider));
}

// ==================== STATE PROVIDERS ====================

/// Provider pour l'état des permissions de notification
@riverpod
Future<bool> notificationPermissionState(Ref ref) async {
  final notificationService = ref.read(notificationServiceUseCaseProvider);
  return await notificationService.checkPermissions();
}

// ==================== NOTIFICATION SERVICE CONTROLLER ====================

/// Contrôleur pour le service de notification
@Riverpod(keepAlive: true)
class NotificationServiceController extends _$NotificationServiceController {
  @override
  Future<bool> build() async {
    // Initialiser le service de notification au démarrage
    return await _initialize();
  }

  /// Initialiser le service de notification
  Future<bool> _initialize() async {
    try {
      final dataSource = ref.read(notificationLocalDataSourceProvider);
      await dataSource.initialize();
      return true;
    } catch (e, stackTrace) {
      // Utiliser le système d'erreur global
      ref.read(errorNotifierProvider.notifier).setError(
            NotificationError(
              operation: 'initialize',
              technicalMessage: 'Failed to initialize notification service: $e',
              originalError: e,
              stackTrace: stackTrace,
            ),
          );
      return false;
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

/// Provider pour vérifier si le service est initialisé
@riverpod
Future<bool> isNotificationServiceInitialized(Ref ref) async {
  final serviceState = await ref.watch(notificationServiceControllerProvider.future);
  return serviceState;
}
