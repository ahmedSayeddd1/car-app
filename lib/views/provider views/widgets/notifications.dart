import 'package:first_project/controllers/provider_controller.dart';
import 'package:first_project/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationsPage extends StatelessWidget {
  final ProviderController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (_controller.notifications.isEmpty) {
          return Center(child: Text('No notifications found'.tr));
        }

        return ListView.builder(
          itemCount: _controller.notifications.length,
          itemBuilder: (context, index) {
            final notification = _controller.notifications[index];
            return _buildNotificationCard(notification);
          },
        );
      }),
    );
  }

  Widget _buildNotificationCard(NotificationModel notification) {
    return Card(
      margin: EdgeInsets.all(8),
      elevation: 4,
      child: ListTile(
        title: Text('New Order Confirmation'.tr),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Time: ${DateFormat('HH:mm').format(notification.timestamp)}'
                .tr),
            Text('Car Size: ${notification.carSize}'.tr),
            Text('Loading: ${notification.placeOfLoading}'.tr),
            Text('Destination: ${notification.destination}'.tr),
          ],
        ),
        trailing: ElevatedButton(
          child: Text('Confirm'.tr),
          onPressed: () => _controller.confirmOrder(notification.orderId),
        ),
      ),
    );
  }
}
