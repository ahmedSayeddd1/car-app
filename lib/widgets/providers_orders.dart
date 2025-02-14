import 'package:first_project/controllers/provider_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProviderOrders extends StatelessWidget {
  final ProviderController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'my_orders'.tr,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                    onPressed: () {
                      _controller.fetchAccomplishedOrders();
                    },
                    child: Text('show_my_orders'.tr))
              ],
            )),
        Divider(),
        Obx(() {
          if (_controller.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (_controller.accomplishedOrders.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Text('no_orders_found'.tr),
            );
          } else {
            return Expanded(
              child: ListView.builder(
                itemCount: _controller.accomplishedOrders.length,
                itemBuilder: (context, index) {
                  final order = _controller.accomplishedOrders[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: ListTile(
                      title: Text('${'order_id'.tr}${order.id}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${'time'.tr}: ${order.time}'),
                          Text('${'destination'.tr}: ${order.destination.tr}'),
                          Text('${'car_size'.tr}: ${order.carSize.tr}'),
                          Text('${'status'.tr}: ${order.status.tr}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        }),
      ],
    ));
  }
}
