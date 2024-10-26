import 'package:best/utils/global_variable/dataApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldQuantity extends StatefulWidget {
  TextFieldQuantity({super.key});
  int index = DataApp.indexQuantityProduct++;
  @override
  State<TextFieldQuantity> createState() => _TextFieldQuantityState();
}

class _TextFieldQuantityState extends State<TextFieldQuantity> {
  final quantityCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 20,width: 30,
      child: TextField(
          controller: quantityCtrl,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (value){
            if(value == ''){
              DataApp.listQuantityProduct[widget.index] = 0;
            }
            DataApp.listQuantityProduct[widget.index] = int.parse(value);
            // print('${widget.index}');
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          )),
    );
  }
}
