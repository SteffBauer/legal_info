import 'package:flutter/material.dart';

import '../../../models/view_detail_model.dart';

const List<Widget> deadlines = <Widget>[
  Text('1 Woche'),
  Text('4 Wochen'),
  Text('3 Monate')
];

class CalculateDeadlinePage extends StatefulWidget implements IViewDetailModel {
  const CalculateDeadlinePage({Key? key}) : super(key: key);

  @override
  State<CalculateDeadlinePage> createState() => _CalculateDeadlinePageState();

  @override
  IconData get icon => Icons.calendar_month;

  @override
  String get title => "Frist berechnen";
}

class _CalculateDeadlinePageState extends State<CalculateDeadlinePage> {
  final List<bool> _selectedDeadline = <bool>[true, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ToggleButtons(
              direction: Axis.horizontal,
              onPressed: (int index) {
                setState(() {
                  // The button that is tapped is set to true, and the others to false.
                  for (int i = 0; i < _selectedDeadline.length; i++) {
                    _selectedDeadline[i] = i == index;
                  }
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: Theme.of(context).primaryColor,
              selectedColor: Theme.of(context).primaryColor,
              fillColor: Colors.grey[200],
              color: Theme.of(context).primaryColor, //Colors.grey[400],
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 80.0,
              ),
              isSelected: _selectedDeadline,
              children: deadlines,
            ),
            Text("Hello World"),
          ],
        ),
      ),
    );
  }
}
