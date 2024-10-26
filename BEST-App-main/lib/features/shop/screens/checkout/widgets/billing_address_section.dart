import 'package:best/common/widgets/texts/section_heading.dart';
import 'package:best/utils/global_variable/dataApp.dart';
import 'package:best/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({
    super.key,
});

  @override
  Widget build(BuildContext context){
    final phoneCtrl = TextEditingController();
    final addressCtrl = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(title: 'Shipping Address', buttonTitle: 'Change', onPressed:(){}),
        Text('Information', style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: TSizes.spaceBtwItems/2),
        Row(
          children: [
            const SizedBox(width: TSizes.spaceBtwItems),
            Expanded(child:
            TextFormField(
              controller: phoneCtrl,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (text) {
                DataApp.order.phone = text;
              },
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone, color: Colors.grey, size: 16),
                  labelText: 'Phone'),
            ),
            )
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems/2),
        Row(
          children: [
            const SizedBox(width: TSizes.spaceBtwItems),
            Expanded(
              child: TextFormField(
                controller: addressCtrl,
                onChanged: (text) {
                  DataApp.order.address = text;
                },
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.location_history, color: Colors.grey, size: 16),
                    labelText: 'Address'),
              ),
            ),
            //Expanded(child: Text('So 7 Thien Quang, HN', style: Theme.of(context).textTheme.bodyMedium, softWrap: true))
          ],
        )
      ],
    );
  }

}