import 'package:flutter/material.dart';
import 'package:legal_info/models/view_detail_model.dart';

class CalculateAlcPage extends StatefulWidget implements IViewDetailModel {
  @override
  final String title = "Restalkohol berechnen";
  @override
  final IconData icon = Icons.no_drinks;

  const CalculateAlcPage({Key? key}) : super(key: key);

  @override
  State<CalculateAlcPage> createState() => _CalculateAlcPageState();
}

class _CalculateAlcPageState extends State<CalculateAlcPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Text(
            'Im Aufbau',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .merge(const TextStyle(color: Colors.red)),
          ),
        ));
  }
}
