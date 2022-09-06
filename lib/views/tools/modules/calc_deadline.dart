import 'package:flutter/material.dart';

import '../../../models/view_detail_model.dart';

class CalculateDeadlinePage extends StatelessWidget
    implements IViewDetailModel {
  const CalculateDeadlinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text("Hello World"),
      ),
    );
  }

  @override
  IconData get icon => Icons.calendar_month;

  @override
  String get title => "Frist berechnen";
}
