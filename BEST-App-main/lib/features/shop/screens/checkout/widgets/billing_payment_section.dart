import 'package:best/api/payment_api.dart';
import 'package:best/common/widgets/texts/section_heading.dart';
import 'package:best/utils/global_variable/dataApp.dart';
import 'package:best/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TBillingPaymentSection extends StatefulWidget {
  const TBillingPaymentSection({Key? key}) : super(key: key);

  @override
  State<TBillingPaymentSection> createState() => _TBillingPaymentSectionState();
}

class _TBillingPaymentSectionState extends State<TBillingPaymentSection> {
  static final Map<int, String> _map = {0: "Select "};
  String _value = _map.entries.first.value;
  List listPayment = [];
   Future<List> _loadDataPayment() async {
    listPayment = await PaymentAPI.getPayments();
    for (var data in listPayment) {
      Map<int, String> map = {data['id'] : data['name']};
      _map.addEntries(map.entries);
    }
    return listPayment;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TSectionHeading(
            title: 'Payment Method'),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        FutureBuilder(
            future: _loadDataPayment(),
            builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
            snapshot.hasData
                ?
            DropdownButton<String>(
              value: _value,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (newValue) {
                setState(() {
                  _value = newValue!;
                  _map.forEach((key, value) {
                    if(_value == value){
                      DataApp.indexPaymentID = key;
                    }
                  });
                });
              },
              items: [
                for (MapEntry<int, String> e in _map.entries)
                  DropdownMenuItem(
                    value: e.value,
                    child: Text(e.value),
                  ),
              ],
            ) : const Center(
              child: CircularProgressIndicator(),
            ))
      ],
    );
  }
}
