import 'package:best/api/user_api.dart';
import 'package:best/common/widgets/images/t_rounded_image.dart';
import 'package:best/utils/global_variable/dataApp.dart';
import 'package:best/utils/constants/sizes.dart';
import 'package:best/utils/validators/validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../model/user.dart';

class EditProfileScreen extends StatefulWidget {
  dynamic ob;
  EditProfileScreen(this.ob,{super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}
enum Genders { male, female , other}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var unameCtrl = TextEditingController();
  var genderCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  var imagesCtrl = TextEditingController();
  var phoneCtrl = TextEditingController();
  var addressCtrl = TextEditingController();
  var birthdayCtrl = TextEditingController();

  DateTime selectedBirthday = DateTime.now();
  Genders? _genders = Genders.male;

  Future<void> _selectDateBirthday(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedBirthday,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedBirthday) {
      setState(() {
        selectedBirthday = picked;
        birthdayCtrl.text = "${selectedBirthday.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<bool> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null) return false;
    imagesCtrl.text = 'assets/images/users/${result.files.first.name}';
    return true;
  }
  @override
  void initState() {
    setState(() {
      if(widget.ob != '') {
        unameCtrl.text = widget.ob['user_name'] ?? '';
        emailCtrl.text = widget.ob['email'] ?? '';
        imagesCtrl.text = widget.ob['image'] ?? '';
        phoneCtrl.text = widget.ob['phone'] ?? '';
        addressCtrl.text = widget.ob['address'] ?? '';
        birthdayCtrl.text = widget.ob['birthday'] ?? '';
        selectedBirthday = DateTime.parse(widget.ob['birthday']);
        genderCtrl.text = widget.ob['gender'].toString() ?? '0';
        (widget.ob['gender'] == 0)
            ? _genders = Genders.male
            : (widget.ob['gender'] == 1) ? _genders = Genders.male : _genders =
            Genders.other;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TRoundedImage(height: 250, width: 250,imageUrl: imagesCtrl.text, applyImageRadius: true),
              const SizedBox(height: TSizes.spaceBtwItems),
              MaterialButton(
                onPressed: () async{
                 bool result = await _pickFile();
                 if(result){
                   setState(() {
                     build(context);
                   });}
                },
                color: Colors.green,
                child: const Text(
                  'Pick and open file',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              /// Edit User
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                      controller: unameCtrl,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: ' Name',
                        labelText: 'UserName',
                      )),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text('Gender'),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ListTile(
                          title: const Text("Male"),
                          trailing: Radio(
                            value: Genders.male,
                            groupValue: _genders,
                            onChanged: (Genders? value) {
                              setState(() {
                                _genders = value;
                                genderCtrl.text = '0';
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ListTile(
                          title: const Text("FeMale"),
                          trailing: Radio(
                            value: Genders.female,
                            groupValue: _genders,
                            onChanged: (Genders? value) {
                              setState(() {
                                _genders = value;
                                genderCtrl.text = '1';
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ListTile(
                          title: const Text('Other'),
                          trailing: Radio(
                            value: Genders.other,
                            groupValue: _genders,
                            onChanged: (Genders? value) {
                              setState(() {
                                _genders = value;
                                genderCtrl.text = '2';
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                      controller: birthdayCtrl,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: ' Name',
                        labelText: 'Birthday',
                      )),
                  ElevatedButton(
                    onPressed: () => _selectDateBirthday(context),
                    child: const Text('Select birthday'),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                      controller: phoneCtrl,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: ' Name',
                        labelText: 'Phone',
                      )),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                      controller: emailCtrl,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: ' abc@gmail.com',
                        labelText: 'Email',
                      )),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.teal,
                        textStyle: const TextStyle(fontSize: 15)),
                    onPressed: () async {
                      dynamic validatedEmail =
                      TValidator.validateEmail(emailCtrl.text);
                      dynamic validatedPhone =
                      TValidator.validatePhoneNumber(phoneCtrl.text);
                      if (validatedEmail == null &&
                          validatedPhone == null) {
                          var user = Users(
                              widget.ob['id'],
                              DataApp.user['first_name'],
                              DataApp.user['last_name'],
                              unameCtrl.text,
                              DataApp.user['password'],
                              int.parse(genderCtrl.text),
                              emailCtrl.text,
                              (imagesCtrl.text.isEmpty)?widget.ob['image']:imagesCtrl.text,
                              phoneCtrl.text,
                              addressCtrl.text,
                              birthdayCtrl.text,1,
                              1);
                          await UserAPI.updateUser(user);
                          DataApp.user = await UserAPI.getUserByID(DataApp.user['id']);
                        Navigator.pop(context,);
                      }else{
                        showDialog(
                            context: context,
                            builder: (builder) {
                              return AlertDialog(
                                content: Text(
                                    '$validatedEmail \n$validatedPhone'),
                              );
                            });
                      }
                    },
                    child: const Text('Edit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}