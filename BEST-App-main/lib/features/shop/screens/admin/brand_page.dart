import 'package:best/common/widgets/images/t_rounded_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../../../api/brand_api.dart';
import '../../../../model/brand.dart';

class BrandPage extends StatefulWidget {
  const BrandPage({Key? key}) : super(key: key);
  @override
  State<BrandPage> createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage> {
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
                    const Text('     Brand'),
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
    listObs = await BrandAPI.getBrands();
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
                                  'BrandID : ${snapshot.data![index]['id']}'),
                              Text(
                                  'name : ${snapshot.data![index]['name']}'),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                        'Description : ${snapshot.data![index]['description']}'),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      height: 90,
                                      width: 90,
                                      child: TRoundedImage(
                                          imageUrl:
                                          '${snapshot.data![index]['image']}',
                                          applyImageRadius: true),
                                    ),
                                  ),
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
                                  var brand =
                                  await BrandAPI.getBrandByID(
                                      snapshot.data![index]
                                      ['id']);
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FormObject(brand,'Edit')),
                                  );
                                  setState(() {
                                    build(context);
                                  });
                                },
                                child: const Icon(Icons.edit)),
                            const Text('\n'),
                            ElevatedButton(
                                onPressed: () async {
                                  await BrandAPI.deleteBrandByID(
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
  dynamic brand;
  dynamic title;
  FormObject(this.brand, this.title, {super.key});

  @override
  State<FormObject> createState() => _FormObject();
}

class _FormObject extends State<FormObject> {
  var nameCtrl = TextEditingController();
  var descriptionCtrl = TextEditingController();
  var imageCtrl = TextEditingController();
  var title = '';
  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null) return;
    imageCtrl.text = 'assets/images/brands/${result.files.first.name}';
  }

  @override
  void initState() {
    setState(() {
      if(widget.brand !=  ''){
        nameCtrl.text = widget.brand['name'] ?? ' ';
        descriptionCtrl.text = widget.brand['description'] ?? ' ';
        imageCtrl.text = widget.brand['image'] ?? ' ';
      }
      title = widget.title;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brand $title'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$title Brand',
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
                    hintText: 'Brand Name',
                    labelText: 'Name',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: descriptionCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Description',
                    labelText: 'Description',
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
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.teal,
                    textStyle: const TextStyle(fontSize: 15)),
                onPressed: () async {
                  if(title == 'Add'){
                    var brand = Brand(0, nameCtrl.text,
                        descriptionCtrl.text, imageCtrl.text);
                    await BrandAPI.addBrand(brand);
                  }else {
                    var brand = Brand(widget.brand['id'], nameCtrl.text,
                        descriptionCtrl.text, imageCtrl.text);
                    await BrandAPI.updateBrand(brand);
                  }
                  Navigator.pop(context, nameCtrl.text);
                },
                child: Text(title),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
