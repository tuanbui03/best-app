import 'package:flutter/material.dart';
import 'widgets/bar_graph.dart';

/*
Task!
Input: List of weekly expenses = [sunAmount, monAmount,... staAmount]
Output: Display in a nice bar graph
 */
class FlowChartScreen extends StatefulWidget {
  const FlowChartScreen({super.key});

  @override
  State<FlowChartScreen> createState() => _HomePageState();
}

class _HomePageState extends State<FlowChartScreen> {
  //list of weekly expense
  List<double> weeklySummary =[
    4.40,
    2.50,
    42.0,
    10.5,
    100.2,
    33.3,
    70
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 300,child: MyBarGraph(weeklySummary: weeklySummary,));
  }
}
