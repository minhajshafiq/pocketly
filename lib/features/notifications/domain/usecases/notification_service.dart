import 'package:pocketly/features/notifications/domain/entities/notification_entity.dart';
import 'package:pocketly/features/notifications/domain/repositories/notification_repository.dart';

/// Use case consolidé pour toutes les opérations de notification
class NotificationService {
  final NotificationRepository _repository;

  NotificationService(this._repository);

  /// Vérifier les permissions de notification
  Future<bool> checkPermissions() async {
    return await _repository.checkPermissions();
  }

  /// Demander les permissions de notification
  Future<bool> requestPermissions() async {
    return await _repository.requestPermissions();
  }

  /// Afficher une notification immédiate
  Future<bool> showNotification(NotificationEntity notification) async {
    return await _repository.showNotification(notification);
  }

  /// Planifier une notification
  Future<bool> scheduleNotification(NotificationEntity notification) async {
    return await _repository.scheduleNotification(notification);
  }

  /// Annuler une notification spécifique
  Future<bool> cancelNotification(int id) async {
    return await _repository.cancelNotification(id);
  }

  /// Annuler toutes les notifications
  Future<bool> cancelAllNotifications() async {
    return await _repository.cancelAllNotifications();
  }

  /// Obtenir le fuseau horaire de l'appareil
  Future<String> getDeviceTimeZone() async {
    return await _repository.getDeviceTimeZone();
  }
}
