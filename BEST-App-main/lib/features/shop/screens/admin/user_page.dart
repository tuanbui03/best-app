import 'package:best/api/user_api.dart';
import 'package:best/model/user.dart';
import 'package:best/utils/validators/validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import '../common/widgets/images/t_rounded_image.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _PageState();
}

class _PageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back)),
                    const Text('     User'),
                  ],
                ),
              ),
              body: const HomePage(),
            )));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List listObs = [];

  Future<List> _loadData() async {
    listObs = await UserAPI.getUsers();
    return listObs;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormObject('', 'Add'),
                    ),
                  );
                  setState(() {
                    build(context);
                  });
                },
                child: const Text('Add')),
          ],
        ),
        Expanded(
          child: FutureBuilder(
              future: _loadData(),
              builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
              snapshot.hasData
                  ? ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, index) => Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    subtitle: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "UserID : ${snapshot.data![index]['id']}"),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                        "UserName : ${snapshot.data![index]['user_name']}"),
                                  ),
                                  // Expanded(
                                  //   flex: 1,
                                  //   child: Container(
                                  //     height: 90,
                                  //     width: 90,
                                  //     child: TRoundedImage(
                                  //         imageUrl:
                                  //             "${snapshot.data![index]['images']}",
                                  //         applyImageRadius: true),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                onPressed: () async {
                                  var user =
                                  await UserAPI.getUserByID(
                                      snapshot.data![index]
                                      ['id']);
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FormObject(user, 'Edit')),
                                  );
                                  setState(() {
                                    build(context);
                                  });
                                },
                                child: const Icon(Icons.edit)),
                            const Text('\n'),
                            ElevatedButton(
                                onPressed: () async {
                                  await UserAPI.deleteUserByID(
                                      snapshot.data![index]
                                      ['id']);
                                  setState(() {});
                                },
                                child: const Icon(Icons.delete)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
                  : const Center(
                // render the loading indicator
                child: CircularProgressIndicator(),
              )),
        ),
      ],
    );
  }
}

class FormObject extends StatefulWidget {
  dynamic ob;
  dynamic title;

  FormObject(this.ob, this.title, {super.key});

  @override
  State<FormObject> createState() => _FormObject();
}

enum Roles { admin, customer }

enum Status { disAction, action }

enum Genders { male, female , other}

class _FormObject extends State<FormObject> {
  var fnameCtrl = TextEditingController();
  var lnameCtrl = TextEditingController();
  var unameCtrl = TextEditingController();
  var passCtrl = TextEditingController();
  var genderCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  var imagesCtrl = TextEditingController();
  var phoneCtrl = TextEditingController();
  var addressCtrl = TextEditingController();
  var birthdayCtrl = TextEditingController();
  var roleCtrl = TextEditingController();
  var statusCtrl = TextEditingController();
  var title = '';
  DateTime selectedBirthday = DateTime.now();
  Roles? _roles = Roles.admin;
  Status? _status = Status.disAction;
  Genders? _genders = Genders.male;

  Future<void> _selectDateBirthday(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedBirthday,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedBirthday) {
      setState(() {
        selectedBirthday = picked;
        birthdayCtrl.text = "${selectedBirthday.toLocal()}".split(' ')[0];
      });
    }
  }

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null) return;
    imagesCtrl.text = 'assets/images/users/${result.files.first.name}';
  }

  @override
  void initState() {
    setState(() {
      if (widget.ob != '') {
        fnameCtrl.text = widget.ob['first_name'] ?? '';
        lnameCtrl.text = widget.ob['last_name'] ?? '';
        unameCtrl.text = widget.ob['user_name'] ?? '';
        passCtrl.text = widget.ob['password'] ?? '';
        emailCtrl.text = widget.ob['email'] ?? '';
        imagesCtrl.text = widget.ob['images'] ?? '';
        phoneCtrl.text = widget.ob['phone'] ?? '';
        addressCtrl.text = widget.ob['address'] ?? '';
        birthdayCtrl.text = widget.ob['birthday'] ?? '';
        selectedBirthday = DateTime.parse(widget.ob['birthday']);

        roleCtrl.text = widget.ob['role'].toString() ;
        statusCtrl.text = widget.ob['status'].toString();
        genderCtrl.text = widget.ob['gender'].toString();
        (widget.ob['gender'] == 0)
            ? _genders = Genders.male
            : _genders = Genders.female;
        (widget.ob['role'] == 0)
            ? _roles = Roles.admin
            : _roles = Roles.customer;
        (widget.ob['status'] == 1)
            ? _status = Status.action
            : _status = Status.disAction;
      }else{
        roleCtrl.text =  '0';
        statusCtrl.text =  '0';
        genderCtrl.text =  '0';
      }
      title = widget.title;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User $title'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$title User',
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              TextField(
                  controller: fnameCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: ' Name',
                    labelText: 'FistName',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: lnameCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: ' Name',
                    labelText: 'LastName',
                  )),
              const SizedBox(
                height: 20.0,
              ),
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
              TextField(
                  controller: passCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: ' Name',
                    labelText: 'Password',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              const Text('Gender'),
              Row(
                children: [
                  Expanded(
                    flex: 2,
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
                  const Expanded(
                    flex: 1,
                    child: Text(''),
                  ),
                  Expanded(
                    flex: 2,
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
                ],
              ),
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
              TextField(
                  controller: imagesCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: ' Name',
                    labelText: 'Images',
                  )),
              MaterialButton(
                onPressed: () {
                  _pickFile();
                },
                color: Colors.green,
                child: const Text(
                  'Pick and open file',
                  style: TextStyle(color: Colors.white),
                ),
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
              //
              const Text('Role'),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ListTile(
                      title: const Text("Admin"),
                      trailing: Radio(
                        value: Roles.admin,
                        groupValue: _roles,
                        onChanged: (Roles? value) {
                          setState(() {
                            _roles = value;
                            roleCtrl.text = '1';
                          });
                        },
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: Text(''),
                  ),
                  Expanded(
                    flex: 2,
                    child: ListTile(
                      title: const Text("Customer"),
                      trailing: Radio(
                        value: Roles.customer,
                        groupValue: _roles,
                        onChanged: (Roles? value) {
                          setState(() {
                            _roles = value;
                            roleCtrl.text = '1';
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
              const Text('Status'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 2,
                    child: ListTile(
                      title: const Text("DisAction"),
                      trailing: Radio(
                        value: Status.disAction,
                        groupValue: _status,
                        onChanged: (Status? value) {
                          setState(() {
                            _status = value;
                            statusCtrl.text = '0';
                          });
                        },
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: Text(''),
                  ),
                  Expanded(
                    flex: 2,
                    child: ListTile(
                      title: const Text("Action"),
                      trailing: Radio(
                        value: Status.action,
                        groupValue: _status,
                        onChanged: (Status? value) {
                          setState(() {
                            _status = value;
                            statusCtrl.text = '1';
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
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.teal,
                    textStyle: const TextStyle(fontSize: 15)),
                onPressed: () async {
                  dynamic validatedEmail =
                  TValidator.validateEmail(emailCtrl.text);
                  dynamic validatedPass =
                  TValidator.validatePassword(passCtrl.text);
                  dynamic validatedPhone =
                  TValidator.validatePhoneNumber(phoneCtrl.text);
                  if (validatedEmail == null &&
                      validatedPass == null &&
                      validatedPhone == null) {
                    if (title == 'Add') {
                      var user = Users(
                          0,
                          fnameCtrl.text,
                          lnameCtrl.text,
                          unameCtrl.text,
                          passCtrl.text,
                          int.parse(genderCtrl.text),
                          emailCtrl.text,
                          imagesCtrl.text,
                          phoneCtrl.text,
                          addressCtrl.text,
                          birthdayCtrl.text,
                          int.parse(roleCtrl.text),
                          int.parse(statusCtrl.text));
                      await UserAPI.addUser(user);
                    } else {
                      var user = Users(
                          widget.ob['id'],
                          fnameCtrl.text,
                          lnameCtrl.text,
                          unameCtrl.text,
                          passCtrl.text,
                          int.parse(genderCtrl.text),
                          emailCtrl.text,
                          imagesCtrl.text,
                          phoneCtrl.text,
                          addressCtrl.text,
                          birthdayCtrl.text,
                          int.parse(roleCtrl.text),
                          int.parse(statusCtrl.text));
                      await UserAPI.updateUser(user);
                    }
                    Navigator.pop(context, fnameCtrl.text);
                  }else{
                    showDialog(
                        context: context,
                        builder: (builder) {
                          return AlertDialog(
                            content: Text(
                                '$validatedEmail \n $validatedPass\n$validatedPhone'),
                          );
                        });
                  }
                },
                child: Text(title),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
