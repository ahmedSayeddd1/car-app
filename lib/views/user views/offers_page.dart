// views/user/offers_page.dart
import 'package:first_project/controllers/client_controller.dart';
import 'package:first_project/models/provider_offer_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OffersPage extends StatelessWidget {
  final ClientController _controller = Get.find<ClientController>();

  bool get hasAcceptedOffer =>
      _controller.offers.any((offer) => offer.status == 'Accepted');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offers'.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _controller.fetchOffers(); // Manually fetch offers
            },
          ),
        ],
      ),
      body: Obx(() {
        if (_controller.offers.isEmpty) {
          return Center(child: Text('No offers found'.tr));
        }

        return ListView.builder(
          itemCount: _controller.offers.length,
          itemBuilder: (context, index) {
            final offer = _controller.offers[index];
            // final formattedTime =
            //     DateFormat('yyyy-MM-dd – HH:mm')
            //         .format(DateTime.parse(offer.timeOfOffer.toString()));

            return _buildOfferCard(offer);
          },
        );
      }),
    );
  }

  Widget _buildOfferCard(ProviderOfferModel offer ) {
    return IgnorePointer(
      ignoring: hasAcceptedOffer && offer.status != 'Accepted',
      child: Opacity(
        opacity: (hasAcceptedOffer && offer.status != 'Accepted') ? 0.5 : 1,
        child: Card(
          margin: const EdgeInsets.all(8),
          elevation: 20,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('اسامة ناصر',
                    //offer.providerName?,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('${offer.distance}${'km away'.tr}',
                    style: const TextStyle(fontSize: 16)),
                Text('${offer.price}${'SAR'.tr}',
                    style: const TextStyle(fontSize: 16)),
                // Text(formattedTime,
                //     style: const TextStyle(fontSize: 14, color: Colors.grey)),
                const SizedBox(height: 16),
                if (offer.status == 'Accepted')
                  Text(
                    'Waiting for provider confirmation...'.tr,
                    style: const TextStyle(fontSize: 16, color: Colors.green),
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                          'Accept'.tr,
                          Colors.green,
                          () =>
                              _controller.changeOfferStatus(offer, 'Accepted')),

                      _buildActionButton('Negotiate'.tr, Colors.orange,
                          () => _showNegotiationDialog(offer)),


                      _buildActionButton(
                          'Reject'.tr,
                          Colors.red,
                          () =>
                              _controller.changeOfferStatus(offer, 'Rejected')),
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: color),
      onPressed: onPressed,
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }

  void _showNegotiationDialog(ProviderOfferModel offer) {
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: Get.context!, // Use Get.context instead of passing context
      builder: (context) => AlertDialog(
        title:Text('Negotiate Price'.tr),
        content: TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'New Price (SAR)'.tr,
            hintText: 'Enter counter offer'.tr,
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child:  Text('Cancel'.tr)),
          TextButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  Get.find<ClientController>()
                      .negotiateOfferPrice(offer, _controller.text);
                  Navigator.pop(context);
                }
              },
              child:  Text('Submit'.tr)),
        ],
      ),
    );
  }
}
