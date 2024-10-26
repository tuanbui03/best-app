import 'package:flutter/material.dart';

import '../../../../api/message_sample_api.dart';
import '../../../../api/messages_api.dart';
import '../../../../api/user_api.dart';
import '../../../../model/message.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);
  @override
  State<MessagePage> createState() => _PageState();
}

class _PageState extends State<MessagePage> {
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
                    const Text('     Message'),
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
    listObs = await MessageAPI.getMessages();
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
                                  "MessageId : ${snapshot.data![index]['id']}"),
                              Text(
                                  "UserName : ${snapshot.data![index]['user']['user_name']}"),
                              Text(
                                  "MessageSample : ${snapshot.data![index]['MessageSample']['content']}"),

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
                                  var ob = await MessageAPI
                                      .getMessageByID(snapshot
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
                                  await MessageAPI
                                      .deleteMessageByID(snapshot
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


// listMessageSample map
Map<int, String> _mapMessageSample = {0: "Select MessageSample "};
String _valueMessageSample = _mapMessageSample.entries.first.value;
List listMessageSample = [];
Future<List> _loadDataMessageSample() async {
  listMessageSample = await MessageSampleAPI.getMessageSamples();
  for (var data in listMessageSample) {
    Map<int, String> map = {data['id']: data['content']};
    _mapMessageSample.addEntries(map.entries);
  }
  return listMessageSample;
}

// listUser map
Map<int, String> _mapUser = {0: "Select User "};
String _valueUser = _mapUser.entries.first.value;
List listUser = [];

Future<List> _loadDataUser() async {
  listUser = await UserAPI.getUsers();
  for (var data in listUser) {
    Map<int, String> map = {data['id']: data['user_name']};
    _mapUser.addEntries(map.entries);
  }
  return listUser;
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
  var messageSampleCtrl = TextEditingController();
  var userCtrl = TextEditingController();
  var dateSentCtrl = TextEditingController();
  var dateReadCtrl = TextEditingController();
  var contentCtrl = TextEditingController();
  var title = '';

  //date Start
  DateTime selectedDateSend = DateTime.now();

  Future<void> _selectDateSend(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDateSend,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateSend) {
      setState(() {
        selectedDateSend = picked;
        dateSentCtrl.text = "${selectedDateSend.toLocal()}".split(' ')[0];
      });
    }
  }

  //date End
  DateTime selectedDateRead = DateTime.now();

  Future<void> _selectDateRead(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDateRead,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateRead) {
      setState(() {
        selectedDateRead = picked;
        dateReadCtrl.text = "${selectedDateRead.toLocal()}".split(' ')[0];
      });
    }
  }
  @override
  void initState() {
    setState(() {
      if (widget.ob != '') {
        messageSampleCtrl.text = widget.ob['messageSample']['id'].toString();
        _valueMessageSample = widget.ob['messageSample']['content'] ?? '';
        userCtrl.text = widget.ob['user']['id'].toString();
        _valueUser = widget.ob['user']['user_name'] ?? '';
        dateSentCtrl.text = widget.ob['date_sent'].toString();
        selectedDateSend = DateTime.parse(widget.ob['date_sent']);
        dateReadCtrl.text = widget.ob['date_read'].toString();
        selectedDateRead = DateTime.parse(widget.ob['date_read']);
        contentCtrl.text = widget.ob['content'].toString();
      }
      title = widget.title;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Message $title'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$title Message',
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              FutureBuilder(
                  future: _loadDataUser(),
                  builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                  snapshot.hasData
                      ? DropdownButton<String>(
                    value: _valueUser,
                    onChanged: (newValue) {
                      setState(() {
                        _valueUser = newValue!;
                        _mapUser.forEach((key, value) {
                          if (_valueUser == value) {
                            userCtrl.text = key.toString();
                          }
                        });
                      });
                    },
                    items: [
                      for (MapEntry<int, String> e in _mapUser.entries)
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
              FutureBuilder(
                  future: _loadDataMessageSample(),
                  builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                  snapshot.hasData
                      ? DropdownButton<String>(
                    value: _valueMessageSample,
                    onChanged: (newValue) {
                      setState(() {
                        _valueMessageSample = newValue!;
                        _mapMessageSample.forEach((key, value) {
                          if (_valueMessageSample == value) {
                            messageSampleCtrl.text = key.toString();
                          }
                        });
                      });
                    },
                    items: [
                      for (MapEntry<int, String> e
                      in _mapMessageSample.entries)
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
                  controller: dateSentCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: ' Date',
                    labelText: 'Day Sent',
                  )),
              ElevatedButton(
                onPressed: () => _selectDateSend(context),
                child: const Text('Select date_send'),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: dateReadCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: ' Date',
                    labelText: 'Day Read',
                  )),
              ElevatedButton(
                onPressed: () => _selectDateRead(context),
                child: const Text('Select date_read'),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: contentCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Content ',
                    labelText: 'Content',
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
                    var ob = Message(0,int.parse(userCtrl.text),
                        int.parse(messageSampleCtrl.text), dateSentCtrl.text, dateReadCtrl.text, contentCtrl.text);
                    await MessageAPI.addMessage(ob);
                  } else {
                    var ob = Message(widget.ob['id'],int.parse(userCtrl.text),
                        int.parse(messageSampleCtrl.text), dateSentCtrl.text, dateReadCtrl.text, contentCtrl.text);
                    await MessageAPI.updateMessage(ob);
                  }
                  Navigator.pop(context);
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

