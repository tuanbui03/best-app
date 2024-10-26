import 'package:best/api/shop_api.dart';
import 'package:best/model/shop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/global_variable/dataApp.dart';
// import '../common/widgets/images/t_rounded_image.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);
  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
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
                    const Text('     Shop'),
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
  dynamic dataShop;
  Future<List> _loadData() async {
    dataShop = await ShopAPI.getShopByID(DataApp.userShopID['id']);
    return listObs;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     ElevatedButton(
        //         onPressed: () async {
        //           await Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //               builder: (context) => FormObject('', 'Add'),
        //             ),
        //           );
        //           setState(() {
        //             build(context);
        //           });
        //         },
        //         child: const Text('Add')),
        //   ],
        // ),
        Expanded(
          child: FutureBuilder(
              future: _loadData(),
              builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
              snapshot.hasData
                  ?  ListView.builder(
    itemCount: 1,
    itemBuilder: (BuildContext context, index) =>Card(
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
                                  'name : ${dataShop['name']}'),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                        'Description : ${dataShop['email']}'),
                                  ),
                                  // Expanded(
                                  //   flex: 1,
                                  //   child: SizedBox(
                                  //     height: 90,
                                  //     width: 90,
                                  //     child: TRoundedImage(
                                  //         imageUrl:
                                  //         '${snapshot.data![index]['image']}',
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
                                  var shop =
                                  await ShopAPI.getShopByID(
                                      dataShop
                                      ['id']);
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FormObject(shop,'Edit')),
                                  );
                                  setState(() {
                                    build(context);
                                  });
                                },
                                child: const Icon(Icons.edit)),
                            // const Text('\n'),
                            // ElevatedButton(
                            //     onPressed: () async {
                            //       await ShopAPI.deleteShopByID(
                            //           snapshot.data![index]
                            //           ['id']);
                            //       setState(() {});
                            //     },
                            //     child: const Icon(Icons.delete)),
                          ],
                        ),
                      ],
                    ),
                  ),)
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
  dynamic shop;
  dynamic title;
  FormObject(this.shop, this.title, {super.key});

  @override
  State<FormObject> createState() => _FormObject();
}

class _FormObject extends State<FormObject> {
  var nameCtrl = TextEditingController();
  var addressCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  var phoneCtrl = TextEditingController();
  var imageCtrl = TextEditingController();
  var title = '';
  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null) return;
    imageCtrl.text = 'assets/images/products/${result.files.first.name}';
  }

  @override
  void initState() {
    setState(() {
      if(widget.shop !=  ''){
        nameCtrl.text = widget.shop['name'] ?? ' ';
        addressCtrl.text = widget.shop['address'] ?? ' ';
        emailCtrl.text = widget.shop['email'] ?? ' ';
        phoneCtrl.text = widget.shop['phone'] ?? ' ';
        imageCtrl.text = widget.shop['image'] ?? ' ';
      }
      title = widget.title;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop $title'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$title Shop',
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Shop Name',
                    labelText: 'Name',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: imageCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Images',
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
              TextField(
                  controller: addressCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Address',
                    labelText: 'Address',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: emailCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                    labelText: 'Email',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: phoneCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Phone',
                    labelText: 'Phone',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.teal,
                    textStyle: const TextStyle(fontSize: 15)),
                onPressed: () async {
                  if(title == 'Add'){
                    var shop = Shop(0, nameCtrl.text,imageCtrl.text,
                        addressCtrl.text, emailCtrl.text, phoneCtrl.text);
                    await ShopAPI.addShop(shop);
                  }else {
                    var shop = Shop(widget.shop['id'], nameCtrl.text,imageCtrl.text,
                        addressCtrl.text, emailCtrl.text, phoneCtrl.text);
                    await ShopAPI.updateShop(shop);
                  }
                  Navigator.pop(context, nameCtrl.text);
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
