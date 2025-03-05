import 'package:first_project/controllers/provider_controller.dart';
import 'package:first_project/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProviderOrders extends StatelessWidget {
  final ProviderController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Filter Section with RadioButtons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'filter_by'.tr, // Translated label
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  // RadioButton for Accomplished Orders
                  Row(
                    children: [
                      Obx(() => Radio<String>(
                            value: 'accomplished',
                            groupValue: _controller.selectedFilter,
                            onChanged: (value) {
                              _controller.updateFilter(value!);
                            },
                          )),
                      Text('accomplished'.tr),
                    ],
                  ),
                  // RadioButton for Under Implementation Orders
                  Row(
                    children: [
                      Obx(() => Radio<String>(
                            value: 'under_implementation',
                            groupValue: _controller.selectedFilter,
                            onChanged: (value) {
                              _controller.updateFilter(value!);
                            },
                          )),
                      Text('under_implementation'.tr),
                    ],
                  ),
                  // RadioButton for Rejected Orders
                  Row(
                    children: [
                      Obx(() => Radio<String>(
                            value: 'rejected',
                            groupValue: _controller.selectedFilter,
                            onChanged: (value) {
                              _controller.updateFilter(value!);
                            },
                          )),
                      Text('rejected'.tr),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            thickness: 1,
            color: Colors.grey, // Subtle divider color
          ),
          // Orders List
          Obx(() {
            if (_controller.isLoading) {
              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(
                        255, 172, 62, 54), // Custom loading color
                  ),
                ),
              );
            } else if (_controller.accomplishedOrders.isEmpty) {
              return Expanded(
                child: Center(
                  child: Text(
                    'no_orders_found'.tr,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ),
              );
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: _controller.accomplishedOrders.length,
                  itemBuilder: (context, index) {
                    final order = _controller.accomplishedOrders[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Card(
                        elevation: 4, // Add shadow for depth
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          title: Text(
                            '${'order_id'.tr}${order.id}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8), // Spacing
                              Text('${'time'.tr}: ${order.time}'),
                              Text(
                                  '${'destination'.tr}: ${order.destination.tr}'),
                              Text('${'car_size'.tr}: ${order.carSize.tr}'),
                              Text(
                                '${'status'.tr}: ${order.status.tr}',
                                style: TextStyle(
                                  color: order.status == 'accomplished'
                                      ? Colors.green
                                      : Colors.orange, // Dynamic status color
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
