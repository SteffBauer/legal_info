import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/view_detail_model.dart';

const List<Widget> deadlines = <Widget>[
  Text('1 Woche'),
  Text('4 Wochen'),
  Text('3 Monate'),
  Text('6 Monate')
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
  DateFormat dateFormat = DateFormat.yMd(Platform.localeName);
  final List<bool> _selectedDeadline = <bool>[true, false, false, false];
  var current = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Row(
              children: <Widget>[
                Text("Start:", style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(
                  width: 20.0,
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text(dateFormat.format(current.toLocal())),
                ),
              ],
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        selectedBorderColor: Theme.of(context).primaryColor,
                        selectedColor: Theme.of(context).primaryColor,
                        fillColor: Colors.grey[200],
                        color:
                            Theme.of(context).primaryColor, //Colors.grey[400],
                        constraints: const BoxConstraints(
                          minHeight: 40.0,
                          minWidth: 80.0,
                        ),
                        isSelected: _selectedDeadline,
                        children: deadlines,
                      ),
                    ],
                  ),
                ]),
            Text("Hello World"),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: current,
        firstDate: DateTime(1900),
        lastDate: DateTime.now().add(const Duration(days: 365 * 100)));

    if (picked != null && picked != current) {
      setState(() {
        current = picked;
      });
    }
  }
}
