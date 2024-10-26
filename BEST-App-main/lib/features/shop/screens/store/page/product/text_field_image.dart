import 'package:best/common/widgets/images/t_rounded_image.dart';
import 'package:best/utils/global_variable/dataApp.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class TextFieldImage extends StatefulWidget {
  String nameColor;
  String image;
  TextFieldImage(this.nameColor,this.image,{super.key});
  int index = DataApp.indexImageProduct++;

  @override
  State<TextFieldImage> createState() => _TextFieldImageState();
}

class _TextFieldImageState extends State<TextFieldImage> {
  var imageCtrl = TextEditingController();
  Future<bool> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null) return false;
    imageCtrl.text = 'assets/images/products/${result.files.first.name}';
    DataApp.listImageProduct[widget.index] = imageCtrl.text;
    return true;
  }
  @override
  Widget build(BuildContext context) {
    if(widget.image != ''){
      imageCtrl.text = widget.image;
    }
    return Column(
      children: [
        Text(' ${widget.nameColor}',),
          if(imageCtrl.text.isNotEmpty)
          SizedBox(
            height: 30,
            width: 30,
            child: TRoundedImage(
                imageUrl:
                imageCtrl.text,
                applyImageRadius: true),
          ),
        TextButton(
          onPressed: () async{
             bool result  = await _pickFile();
             if(result){
              setState(() {
                build(context);
              });}
          },
          child: const Text(
            'Select Photo',
          ),
        ),
      ],
    );
  }
}
