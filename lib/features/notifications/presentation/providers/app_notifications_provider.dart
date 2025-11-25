import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pocketly/features/notifications/domain/entities/app_notification_entity.dart';
import 'package:pocketly/features/user/user.dart';

part 'app_notifications_provider.g.dart';

/// Provider pour la liste de toutes les notifications de l'utilisateur
@riverpod
class AppNotifications extends _$AppNotifications {
  @override
  Future<List<AppNotificationEntity>> build() async {
    final user = await ref.watch(currentUserProvider.future);
    if (user == null) return [];

    // TODO: Charger depuis Supabase ou stockage local
    // Pour l'instant, retourner des notifications de démo
    return _generateDemoNotifications(user.id);
  }

  /// Génère des notifications de démo
  List<AppNotificationEntity> _generateDemoNotifications(String userId) {
    final now = DateTime.now();
    return [
      AppNotificationEntity(
        id: '1',
        userId: userId,
        title: 'Budget dépassé',
        message: 'Votre budget Nourriture a été dépassé de 50€',
        type: AppNotificationType.budgetExceeded,
        createdAt: now.subtract(const Duration(hours: 2)),
        isRead: false,
        relatedEntityId: 'pocket_1',
      ),
      AppNotificationEntity(
        id: '2',
        userId: userId,
        title: 'Objectif atteint !',
        message: 'Félicitations ! Vous avez atteint votre objectif d\'épargne Vacances',
        type: AppNotificationType.goalReached,
        createdAt: now.subtract(const Duration(days: 1)),
        isRead: false,
        relatedEntityId: 'pocket_2',
      ),
      AppNotificationEntity(
        id: '3',
        userId: userId,
        title: 'Résumé hebdomadaire',
        message: 'Cette semaine, vous avez économisé 120€ !',
        type: AppNotificationType.weeklySummary,
        createdAt: now.subtract(const Duration(days: 2)),
        isRead: true,
      ),
      AppNotificationEntity(
        id: '4',
        userId: userId,
        title: 'Rappel fin de mois',
        message: 'Il reste 5 jours avant la fin du mois',
        type: AppNotificationType.monthEndReminder,
        createdAt: now.subtract(const Duration(days: 3)),
        isRead: true,
      ),
    ];
  }

  /// Marque une notification comme lue
  Future<void> markAsRead(String notificationId) async {
    state = await AsyncValue.guard(() async {
      final notifications = state.value ?? [];
      final updated = notifications.map((n) {
        if (n.id == notificationId) {
          return n.copyWith(isRead: true);
        }
        return n;
      }).toList();
      return updated;
    });
  }

  /// Marque une notification comme non lue
  Future<void> markAsUnread(String notificationId) async {
    state = await AsyncValue.guard(() async {
      final notifications = state.value ?? [];
      final updated = notifications.map((n) {
        if (n.id == notificationId) {
          return n.copyWith(isRead: false);
        }
        return n;
      }).toList();
      return updated;
    });
  }

  /// Marque toutes les notifications comme lues
  Future<void> markAllAsRead() async {
    state = await AsyncValue.guard(() async {
      final notifications = state.value ?? [];
      return notifications.map((n) => n.copyWith(isRead: true)).toList();
    });
  }

  /// Supprime une notification
  Future<void> deleteNotification(String notificationId) async {
    state = await AsyncValue.guard(() async {
      final notifications = state.value ?? [];
      return notifications.where((n) => n.id != notificationId).toList();
    });
  }

  /// Supprime toutes les notifications
  Future<void> deleteAllNotifications() async {
    state = const AsyncValue.data([]);
  }

  /// Ajoute une nouvelle notification
  Future<void> addNotification(AppNotificationEntity notification) async {
    state = await AsyncValue.guard(() async {
      final notifications = state.value ?? [];
      return [notification, ...notifications];
    });
  }
}

/// Provider pour les notifications non lues
@riverpod
Future<List<AppNotificationEntity>> unreadNotifications(Ref ref) async {
  final notifications = await ref.watch(appNotificationsProvider.future);
  return notifications.where((n) => !n.isRead).toList();
}

/// Provider pour les notifications lues
@riverpod
Future<List<AppNotificationEntity>> readNotifications(Ref ref) async {
  final notifications = await ref.watch(appNotificationsProvider.future);
  return notifications.where((n) => n.isRead).toList();
}

/// Provider pour le nombre de notifications non lues
@riverpod
Future<int> unreadNotificationsCount(Ref ref) async {
  final unread = await ref.watch(unreadNotificationsProvider.future);
  return unread.length;
}
