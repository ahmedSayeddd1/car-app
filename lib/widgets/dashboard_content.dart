import 'package:first_project/controllers/provider_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardContent extends StatelessWidget {
  final ProviderController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Provider status
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                _controller.loadRequests();
              },
              child: Text('load_requests'.tr),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(() => Text(
                    _controller.isAvailable
                        ? 'status_available'.tr
                        : 'status_busy'.tr,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color:
                          _controller.isAvailable ? Colors.green : Colors.red,
                    ),
                  )),
            ),
          ],
        ),
        Divider(),
        // List of service requests
        Expanded(
          child: Obx(() {
            if (_controller.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (_controller.serviceRequests.isEmpty) {
              return Center(child: Text('no_requests_found'.tr));
            } else {
              return ListView.builder(
                itemCount: _controller.visibleRequests,
                itemBuilder: (context, index) {
                  if (index >= _controller.serviceRequests.length) {
                    return SizedBox();
                  }
                  final request = _controller.serviceRequests[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: ListTile(
                      title: Text('${'request_id'.tr}${request.id}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${'time'.tr}: ${request.time}'),
                          Text('${'destination'.tr}: ${request.destination}'),
                          Text('${'car_size'.tr}: ${request.carSize}'),
                          Text('${'car_status'.tr}: ${request.carStatus}'),
                          Text(
                              '${'place_of_loading'.tr}: ${request.placeOfLoading}'),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'service_pricing'.tr,
                              labelStyle: TextStyle(color: Color(0xffB48481)),
                              hintText: 'enter_amount'.tr,
                              errorText: request.servicePricing == null &&
                                      (request.servicePricing!.isEmpty ||
                                          double.tryParse(
                                                  request.servicePricing!) ==
                                              null ||
                                          double.parse(
                                                  request.servicePricing!) <=
                                              0)
                                  ? 'valid_price_error'.tr
                                  : null,
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              request.servicePricing = value;
                            },
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.visibility_off),
                            onPressed: () =>
                                _controller.hideRequest(request.id),
                          ),
                          IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () => _controller.sendOffer(
                                request.id, request.servicePricing),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }),
        ),
        Obx(() {
          if (_controller.visibleRequests <
              _controller.serviceRequests.length) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _controller.loadMoreRequests,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 172, 62, 54),
                  elevation: 5,
                ),
                child: Text(
                  'more'.tr,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          } else {
            return SizedBox();
          }
        }),
      ],
    );
  }
}
