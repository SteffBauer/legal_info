import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:legal_info/models/view_detail_model.dart';

class CalculateAgePage extends StatefulWidget implements IViewDetailModel {
  @override
  final String title = "Alter berechnen";
  @override
  final IconData icon = Icons.calculate;

  const CalculateAgePage({Key? key}) : super(key: key);

  @override
  State<CalculateAgePage> createState() => _CalculateAgePageState();
}

enum DateType {
  birthday,
  current,
}

class _CalculateAgePageState extends State<CalculateAgePage> {
  var birthday = DateTime(DateTime.now().year - 20, 1, 1);
  var current = DateTime.now();
  DateFormat dateFormat = DateFormat.yMd(Platform.localeName);

  @override
  void initState() {
    super.initState();
  }

  Future<void> _selectDate(BuildContext context, DateType dateType) async {
    DateTime dateTime;
    if (dateType == DateType.birthday) {
      dateTime = birthday;
    } else {
      dateTime = current;
    }

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(1900),
        lastDate: DateTime.now().add(const Duration(days: 365 * 100)));

    if (picked != null && picked != dateTime) {
      setState(() {
        if (dateType == DateType.birthday) {
          birthday = picked;
        } else {
          current = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: IntrinsicWidth(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text("Geboren am",
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(
                  width: 20.0,
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context, DateType.birthday),
                  child: Text(dateFormat.format(birthday.toLocal())),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text("Zeitpunkt",
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(
                  width: 20.0,
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context, DateType.current),
                  child: Text(dateFormat.format(current.toLocal())),
                ),
              ],
            ),
            const SizedBox(height: 48),
            Text(
              birthday.isBefore(current)
                  ? 'Alter: ${_calculateAge(birthday, current)} Jahre'
                  : 'Noch nicht geborens',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.left,
            ),
          ]),
        ),
      ),
    );
  }

  _calculateAge(DateTime birthday, DateTime current) {
    final age = current.difference(birthday).inDays ~/ 365;
    return age;
  }
}
