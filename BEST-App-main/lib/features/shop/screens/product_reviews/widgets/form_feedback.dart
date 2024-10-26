import 'package:best/api/feedback_api.dart';
import 'package:best/utils/global_variable/dataApp.dart';
import 'package:best/model/feedback.dart';
import 'package:flutter/material.dart';

class MyRating extends StatefulWidget {
  dynamic product;
  int rating = 0;
  MyRating(this.rating, this.product, {super.key});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyRating();
  }
}

class _MyRating extends State<MyRating> {
  int numberRate = 0;
  final textFeedback = TextEditingController();
  @override
  void initState() {
    super.initState();
    numberRate = widget.rating;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      style: TextButton.styleFrom(foregroundColor: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("X")),
                  Expanded(flex: 3,child: Text('${widget.product['name']}', style: const TextStyle(fontSize: 18),),),
                  TextButton(
                      onPressed: () async{
                        Feedbacks feedback = Feedbacks(0, DataApp.user['id'], widget.product['id'], textFeedback.text, numberRate, '');
                        await FeedbackAPI.addFeedback(feedback);
                        Navigator.pop(context, numberRate);
                      },
                      child: const Text("Submit")),
                ],
              ),
              const Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(''),
                  Text('Feedback from customers'),
                  Text('')
                ],
              ),
              const Divider(),
              const Text('\n\n\n'),
              Row(
                children: [
                  TextButton(
                    onPressed: null,
                    child: Text(DataApp.user['user_name'][0]),
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "\t${DataApp.user['user_name']}",
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const Text(
                            "\t\tThese are public reviews and \n  contains your device information. Find out more"),
                      ]),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for(int i = 1; i <= 5; i++)
                    IconButton(
                      onPressed: () {
                        setState(() {
                          numberRate = i;
                        });
                      },
                      icon: Icon(numberRate > i-1 ? Icons.star : Icons.star_border),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: textFeedback,
                  decoration: const InputDecoration(border: OutlineInputBorder()),
                ),
              ),
              const Text("Tell us more information (optional)"),
              const CircularProgressIndicator()
            ],
          )),
      debugShowCheckedModeBanner: false,
    );
  }
}
