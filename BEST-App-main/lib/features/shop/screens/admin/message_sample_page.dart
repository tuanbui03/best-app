import 'package:best/api/message_sample_api.dart';
import 'package:best/api/shop_api.dart';
import 'package:best/model/message_sample.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MessageSamplePage extends StatefulWidget {
  const MessageSamplePage({Key? key}) : super(key: key);
  @override
  State<MessageSamplePage> createState() => _PageState();
}

class _PageState extends State<MessageSamplePage> {
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
                    const Text('     MessageSample'),
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
    listObs = await MessageSampleAPI.getMessageSamples();
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
                                  "MessageSampleId : ${snapshot.data![index]['id']}"),
                              Text(
                                  "Shop : ${snapshot.data![index]['shop']['name']}"),
                              Text(
                                  "Question : ${snapshot.data![index]['question']}"),
                              Text(
                                  "Answer : ${snapshot.data![index]['answer']}"),

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
                                  var ob = await MessageSampleAPI
                                      .getMessageSampleByID(snapshot
                                      .data![index]['id']);
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FormObject(ob, 'Edit')),
                                  );
                                  setState(() {
                                    build(context);
                                  });
                                },
                                child: const Icon(Icons.edit)),
                            const Text('\n'),
                            ElevatedButton(
                                onPressed: () async {
                                  await MessageSampleAPI
                                      .deleteMessageSampleByID(snapshot
                                      .data![index]['id']);
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

// listShop map
Map<int, String> _mapShop = {0: "Select Shop "};
String _valueShop = _mapShop.entries.first.value;
List listShop = [];

Future<List> _loadDataShop() async {
  listShop = await ShopAPI.getShops();
  for (var data in listShop) {
    Map<int, String> map = {data['id']: data['name']};
    _mapShop.addEntries(map.entries);
  }
  return listShop;
}
int colorImageID = 0;
class FormObject extends StatefulWidget {
  dynamic ob;
  dynamic title;

  FormObject(this.ob, this.title, {super.key});

  @override
  State<FormObject> createState() => _FormObject();
}

class _FormObject extends State<FormObject> {
  var shopCtrl = TextEditingController();
  var questionCtrl = TextEditingController();
  var answerCtrl = TextEditingController();
  var title = '';

  @override
  void initState() {
    setState(() {
      if (widget.ob != '') {
        shopCtrl.text = widget.ob['shop']['id'].toString();
        _valueShop = widget.ob['shop']['name'] ?? '';
        questionCtrl.text = widget.ob['question'] ?? '';
        answerCtrl.text = widget.ob['answer'] ?? '';
      }
      title = widget.title;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MessageSample $title'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$title MessageSample',
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              FutureBuilder(
                  future: _loadDataShop(),
                  builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                  snapshot.hasData
                      ? DropdownButton<String>(
                    value: _valueShop,
                    onChanged: (newValue) {
                      setState(() {
                        _valueShop = newValue!;
                        _mapShop.forEach((key, value) {
                          if (_valueShop == value) {
                            shopCtrl.text = key.toString();
                          }
                        });
                      });
                    },
                    items: [
                      for (MapEntry<int, String> e in _mapShop.entries)
                        DropdownMenuItem(
                          value: e.value,
                          child: Text(e.value),
                        ),
                    ],
                  )
                      : const Center(
                    child: CircularProgressIndicator(),
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: questionCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Question ',
                    labelText: 'Question',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: answerCtrl,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Answer ',
                    labelText: 'Answer',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.teal,
                    textStyle: const TextStyle(fontSize: 15)),
                onPressed: () async {
                  if (title == 'Add') {
                    var ob = MessageSample(0,int.parse(shopCtrl.text),questionCtrl.text, answerCtrl.text);
                    await MessageSampleAPI.addMessageSample(ob);
                  } else {
                    var ob = MessageSample(widget.ob['id'],int.parse(shopCtrl.text),questionCtrl.text, answerCtrl.text);
                    await MessageSampleAPI.addMessageSample(ob);
                  }
                  Navigator.pop(context,);
                },
                child: Text(title),
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

