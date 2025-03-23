import 'package:first_project/controllers/provider_controller.dart';
import 'package:first_project/models/provider_offer_model.dart';
import 'package:first_project/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
                    style: const TextStyle(
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
                    return  OrderCard(order: order);

                    //   Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 16, vertical: 8),
                    //   child: Card(
                    //     elevation: 4, // Add shadow for depth
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius:
                    //           BorderRadius.circular(10), // Rounded corners
                    //     ),
                    //     child: ListTile(
                    //       contentPadding: const EdgeInsets.all(16),
                    //       title: Text(
                    //         '${'order_id'.tr}${order.id}',
                    //         style: const TextStyle(
                    //           fontSize: 18,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //       subtitle: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           const SizedBox(height: 8), // Spacing
                    //           Text('${'time'.tr}: ${order.timeOfOffer}'),
                    //           Text(
                    //               '${'destination'.tr}: ${order.destination.tr}'),
                    //           Text('${'car_size'.tr}: ${order.carSize.tr}'),
                    //           Text(
                    //             '${'status'.tr}: ${order.status.tr}',
                    //             style: TextStyle(
                    //               color: order.status == 'accomplished'
                    //                   ? Colors.green
                    //                   : Colors.orange, // Dynamic status color
                    //               fontWeight: FontWeight.bold,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // );
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


class OrderCard extends StatelessWidget {
  final ProviderOfferModel order;

  const OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Format the Timestamp to a human-readable string
    final formattedTime = DateFormat('MMMM d, y, h:mm a').format(
      order.timeOfOffer.toDate(),
    );


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 4, // Add shadow for depth
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10), // Rounded corners for InkWell
          onTap: () {
            // Add navigation or action when the card is tapped
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order ID
                Text(
                  '${'order_id'.tr}: ${order.id}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8), // Spacing

                // Time of Offer
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: Colors.grey),
                    const SizedBox(width: 8), // Spacing
                    Text(
                      '${'time'.tr}: $formattedTime',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 8), // Spacing

                // Destination
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 8), // Spacing
                    Text(
                      '${'destination'.tr}: ${order.destination.tr}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 8), // Spacing

                // Car Size
                Row(
                  children: [
                    const Icon(Icons.directions_car, size: 16, color: Colors.grey),
                    const SizedBox(width: 8), // Spacing
                    Text(
                      '${'car_size'.tr}: ${order.carSize.tr}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 8), // Spacing

                // Status
                Row(
                  children: [
                    const Icon(Icons.info, size: 16, color: Colors.grey),
                    const SizedBox(width: 8), // Spacing
                    Text(
                      '${'status'.tr}: ',
                      style: const TextStyle(fontSize: 14),
                    ),
                    (order.status == 'Pending')?
                    Text(
                      'بانتظار الموافقة ',
                      style: TextStyle(
                        fontSize: 14,
                        color: order.status == 'accomplished'
                            ? Colors.green
                            : Colors.orange, // Dynamic status color
                        fontWeight: FontWeight.bold,
                      ),
                    ):const SizedBox(),
                  ],
                ),
                const SizedBox(height: 16),


                (order.status=='Pending')?
             Row(
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  children: [
                  const Icon(Icons.call, size: 16, color: Colors.green),

                  ElevatedButton(

                      onPressed:(){

                  } , child: const Text("اتصل الان",style:TextStyle(
                    color:Colors.green,
                  ),)),


                    ElevatedButton(

                        onPressed:(){

                        } , child: const Text("اتصل بي ",style:TextStyle(
                      color:Colors.green,
                    ),))




                ],):const SizedBox(),

                // Call-to-Action Button
                // Center(
                //   child: ElevatedButton(
                //     onPressed: () {
                //       // Add action for the button
                //     },
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.blue, // Button color
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(8), // Rounded corners
                //       ),
                //     ),
                //     child: Text(
                //       'view_details'.tr,
                //       style: const TextStyle(color: Colors.white),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
