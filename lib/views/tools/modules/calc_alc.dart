import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:legal_info/models/enum_gender.dart';
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
  GenderType? _gender = GenderType.male;

  @override
  Widget build(BuildContext context) {
    // Generate radio buttons for gender
    List<Widget> genders = <Widget>[];
    for (var genderType in GenderType.values) {
      Gender gender = Gender(genderType);

      var box = Row(children: [
        Text(gender.toString()),
        Radio(
          value: genderType,
          groupValue: _gender,
          onChanged: (GenderType? value) {
            setState(() {
              _gender = value;
            });
          },
        ),
      ]);
      genders.add(box);
    }

    var spaceBetweenFields = 10.0;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(children: [
              Column(
                children: [
                  Text(
                    "Geschlecht",
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
              Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: genders),
              )
            ]),
            SizedBox(height: spaceBetweenFields),
            TextField(
              decoration: const InputDecoration(
                labelText: "Gewicht in kg",
              ),
              keyboardType: TextInputType.number,
              onChanged: (String value) {
                // todo set value
                if (kDebugMode) {
                  print(value);
                }
              },
            ),
            SizedBox(height: spaceBetweenFields),
            TextField(
              decoration: const InputDecoration(
                labelText: "Körpergröße in cm",
              ),
              keyboardType: TextInputType.number,
              onChanged: (String value) {
                // todo set value
                if (kDebugMode) {
                  print(value);
                }
              },
            ),
            SizedBox(height: spaceBetweenFields),
            TextField(
              decoration: const InputDecoration(
                labelText: "Alkohol in Prozent",
              ),
              keyboardType: TextInputType.number,
              onChanged: (String value) {
                // todo set value
                if (kDebugMode) {
                  print(value);
                }
              },
            ),
            SizedBox(height: spaceBetweenFields),
          ],
        ),
      ),
    );
  }
}
