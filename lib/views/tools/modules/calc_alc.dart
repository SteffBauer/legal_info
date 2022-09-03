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
  final _controllerHeight = TextEditingController();
  final _controllerWheight = TextEditingController();

  GenderType? _gender = GenderType.male;
  var _weight = 80.0;
  var _height = 180;

  @override
  void initState() {
    super.initState();

    _controllerHeight.text = _height.toString();
    _controllerHeight.selection =
        TextSelection(baseOffset: 0, extentOffset: _height.toString().length);
    _controllerHeight.value = TextEditingValue(
      text: _controllerHeight.text,
      selection: _controllerHeight.selection,
      composing: TextRange.empty,
    );

    _controllerWheight.text = _weight.toString();
    _controllerWheight.selection =
        TextSelection(baseOffset: 0, extentOffset: _weight.toString().length);
    _controllerWheight.value = TextEditingValue(
      text: _controllerWheight.text,
      selection: _controllerWheight.selection,
      composing: TextRange.empty,
    );
  }

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
          activeColor: Theme.of(context).primaryColor,
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
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Gewicht in kg",
              ),
              keyboardType: TextInputType.number,
              controller: _controllerWheight,
              onTap: () {
                _controllerWheight.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: _controllerWheight.text.length);
              },
              onChanged: (String value) {
                setState(() {
                  _weight = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            SizedBox(height: spaceBetweenFields),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Körpergröße in cm",
              ),
              keyboardType: TextInputType.number,
              controller: _controllerHeight,
              onTap: () {
                _controllerHeight.selection = TextSelection(
                    baseOffset: 0, extentOffset: _controllerHeight.text.length);
              },
              onChanged: (String value) {
                setState(() {
                  _height = int.tryParse(value) ?? 0;
                });
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
            SizedBox(height: spaceBetweenFields),
            ElevatedButton(
                onPressed: (() {
                  // todo calculate
                  if (kDebugMode) {
                    print("Höhe: $_height");
                    print("Gewicht: $_weight");
                  }
                }),
                child: Text("Berechnen"))
          ],
        ),
      ),
    );
  }
}
