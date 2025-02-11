import 'package:first_project/controllers/provider_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProviderDashboard extends StatelessWidget {
  final ProviderController _controller = Get.put(ProviderController(
      providerId: '123456789')); // Set provider ID during login

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Dashboard'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Obx(() => Icon(
                  _controller.isAvailable ? Icons.check_circle : Icons.block,
                )),
            onPressed: _controller.toggleAvailability,
          ),
        ],
      ),
      body: Column(
        children: [
          // Provider status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    _controller.loadRequests();
                  },
                  child: Text('Load requests')),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() => Text(
                      _controller.isAvailable
                          ? 'Status: Available'
                          : 'Status: Busy',
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
              if (_controller.serviceRequests.isEmpty) {
                return Center(child: Text('No requests found'));
              }
              return ListView.builder(
                itemCount: _controller.visibleRequests,
                itemBuilder: (context, index) {
                  final request = _controller.serviceRequests[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: ListTile(
                      title: Text('Request #${request.id}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Time: ${request.time}'),
                          Text('Destination: ${request.destination}'),
                          Text('Car Size: ${request.carSize}'),
                          Text('Car Status: ${request.carStatus}'),
                          Text('Place of Loading: ${request.placeOfLoading}'),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Service Pricing',
                              labelStyle: TextStyle(color: Color(0xffB48481)),
                              hintText: 'Enter amount',
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
                    'MORE',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            } else {
              return SizedBox();
            }
          }),
        ],
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:first_project/controllers/provider_controller.dart';

// class ProviderDashboard extends StatelessWidget {
//   final ProviderController _controller = Get.put(ProviderController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Provider Dashboard'),
//         centerTitle: true,
//         actions: [
//           // Toggle availability
//           IconButton(
//             icon: Obx(() => Icon(
//                   _controller.isAvailable ? Icons.check_circle : Icons.block,
//                 )),
//             onPressed: _controller.toggleAvailability,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Provider status
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Obx(() => Text(
//                   _controller.isAvailable
//                       ? 'Status: Available'
//                       : 'Status: Busy',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: _controller.isAvailable ? Colors.green : Colors.red,
//                   ),
//                 )),
//           ),
//           Divider(),
//           // List of service requests
//           Expanded(
//             child: Obx(() => ListView.builder(
//                   itemCount: _controller.visibleRequests,
//                   itemBuilder: (context, index) {
//                     final request = _controller.serviceRequests[index];
//                     return Card(
//                       margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                       child: ListTile(
//                         title: Text('Request #${request.id}'),
//                         subtitle: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Time: ${request.time}'),
//                             Text('Place of Loading: ${request.placeOfLoading}'),
//                             Text('Destination: ${request.destination}'),
//                             Text('Car Size: ${request.carSize}'),
//                             Text('Car Status: ${request.carStatus}'),
//                             TextField(
//                               decoration: InputDecoration(
//                                 labelText: 'Service Pricing',
//                                 labelStyle: TextStyle(color: Color(0xffB48481)),
//                                 hintText: 'Enter amount',
//                               ),
//                               keyboardType: TextInputType.number,
//                               onChanged: (value) {
//                                 request.servicePricing = value;
//                               },
//                             ),
//                           ],
//                         ),
//                         trailing: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             IconButton(
//                               icon: Icon(Icons.visibility_off),
//                               onPressed: () => _controller.hideRequest(index),
//                             ),
//                             IconButton(
//                               icon: Icon(Icons.send),
//                               onPressed: () => _controller.sendOffer(index),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 )),
//           ),
//           // MORE button
//           Obx(() {
//             if (_controller.visibleRequests <
//                 _controller.serviceRequests.length) {
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ElevatedButton(
//                   onPressed: _controller.loadMoreRequests,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color.fromARGB(255, 172, 62, 54),
//                     elevation: 5,
//                   ),
//                   child: Text(
//                     'MORE',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               );
//             } else {
//               return SizedBox();
//             }
//           }),
//         ],
//       ),
//     );
//   }
// }

