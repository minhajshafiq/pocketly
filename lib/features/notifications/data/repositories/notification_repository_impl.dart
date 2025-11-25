import 'package:pocketly/features/notifications/data/datasources/notification_local_datasource.dart';
import 'package:pocketly/features/notifications/data/models/notification_model.dart';
import 'package:pocketly/features/notifications/domain/entities/notification_entity.dart';
import 'package:pocketly/features/notifications/domain/repositories/notification_repository.dart';

/// Implementation of the notification repository
class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationLocalDataSource localDataSource;
  
  NotificationRepositoryImpl({
    required this.localDataSource,
  });
  
  @override
  Future<bool> checkPermissions() async {
    return await localDataSource.checkPermissions();
  }
  
  @override
  Future<bool> requestPermissions() async {
    return await localDataSource.requestPermissions();
  }
  
  @override
  Future<bool> scheduleNotification(NotificationEntity notification) async {
    if (notification.scheduledDate == null) {
      throw ArgumentError('Scheduled date must not be null for scheduling notifications');
    }
    
    return await localDataSource.scheduleNotification(
      id: notification.id,
      title: notification.title,
      body: notification.body,
      payload: notification.payload,
      scheduledDate: notification.scheduledDate!,
    );
  }
  
  @override
  Future<bool> showNotification(NotificationEntity notification) async {
    return await localDataSource.showNotification(
      id: notification.id,
      title: notification.title,
      body: notification.body,
      payload: notification.payload,
    );
  }
  
  @override
  Future<bool> cancelNotification(int id) async {
    return await localDataSource.cancelNotification(id);
  }
  
  @override
  Future<bool> cancelAllNotifications() async {
    return await localDataSource.cancelAllNotifications();
  }
  
  @override
  Future<String> getDeviceTimeZone() async {
    return await localDataSource.getDeviceTimeZone();
  }
}
